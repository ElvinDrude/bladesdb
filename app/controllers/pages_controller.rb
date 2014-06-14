class PagesController < ApplicationController
    before_filter :check_admin_or_committee_role, :except => [ :show, :home ]

    # GET /pages
    # GET /pages.xml
    def index
        @pages = Page.all

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @pages }
        end
    end

    def home
        @page = Page.find(1)
        respond_to do |format|
            format.html { render :show }
        end
    end

    # GET /pages/1
    # GET /pages/1.xml
    def show
        @page = Page.find(params[:id])

        if @page[:show_to_non_users] || current_user
            respond_to do |format|
                format.html # show.html.erb
                format.xml  { render :xml => @page }
            end
        else
            permission_denied("You must be logged in to view that page.")
        end
    end

    # GET /pages/new
    # GET /pages/new.xml
    def new
        @page ||= Page.new
        @preview = false

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @page }
        end
    end

    # GET /pages/1/edit
    def edit
        @page ||= Page.find(params[:id])
        @preview = false
    end

    # POST /pages
    # POST /pages.xml
    def create
        case params[:commit]
        when "Save"
            @page = Page.new(page_params)

            respond_to do |format|
                if @page.save
                    flash[:notice] = 'Page was successfully created.'
                    format.html { redirect_to(@page) }
                    format.xml  { render :xml => @page, :status => :created, :location => @page }
                else
                    format.html { render :action => "new" }
                    format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
                end
            end
        when "Preview"
            @page = Page.new(page_params)
            @preview = true
            render :action => "new"
        end
    end

    # PUT /pages/1
    # PUT /pages/1.xml
    def update
        case params[:commit]
        when "Save"
            @page = Page.find(params[:id])

            respond_to do |format|
                if @page.update_attributes(page_params)
                    flash[:notice] = 'Page was successfully updated.'
                    format.html { redirect_to(@page) }
                    format.xml  { head :ok }
                else
                    format.html { render :action => "edit" }
                    format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
                end
            end
        when "Preview"
            @page = Page.find( params[:id] )
            @page[:title]             = params[:page][:title]
            @page[:content]           = params[:page][:content]
            @page[:show_to_non_users] = params[:page][:show_to_non_users]
            @preview = true
            render :action => "edit"
        end
    end

    # DELETE /pages/1
    # DELETE /pages/1.xml
    def destroy
        @page = Page.find(params[:id])
        @page.destroy

        respond_to do |format|
            format.html { redirect_to(pages_url) }
            format.xml  { head :ok }
        end
    end
    
    protected
    
        def page_params
            params.require(:page).permit(:title, :content, :show_to_non_users)
        end

end