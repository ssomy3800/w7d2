class BandsController < ApplicationController
    before_action :set_band, only: [:show, :edit, :update, :destroy]
  
    # GET /bands
    def index
      @bands = Band.all
    end
  
    # GET /bands/1
    def show
    end
  
    # GET /bands/new
    def new
      @band = Band.new
    end
  
    # GET /bands/1/edit
    def edit
    end
  
    # POST /bands
    def create
      @band = Band.new(band_params)
  
      if @band.save
        redirect_to @band, notice: 'Band was successfully created.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /bands/1
    def update
      if @band.update(band_params)
        redirect_to @band, notice: 'Band was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /bands/1
    def destroy
      @band.destroy
      redirect_to bands_url, notice: 'Band was successfully destroyed.'
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_band
      @band = Band.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def band_params
      params.require(:band).permit(:name, :genre, :year_formed)
    end
  end
  And here are example views for the index, show, new, edit, and destroy actions:
  
  html
  Copy code
  <!-- app/views/bands/index.html.erb -->
  <h1>Bands</h1>
  
  <ul>
    <% @bands.each do |band| %>
      <li>
        <%= link_to band.name, band %>
        <%= link_to 'Edit', edit_band_path(band) %>
        <%= link_to 'Destroy', band, method: :delete, data: { confirm: 'Are you sure?' } %>
      </li>
    <% end %>
  </ul>
  
  <%= link_to 'New Band', new_band_path %>
  html
  Copy code
  <!-- app/views/bands/show.html.erb -->
  <h1><%= @band.name %></h1>
  
  <p><strong>Genre:</strong> <%= @band.genre %></p>
  <p><strong>Year Formed:</strong> <%= @band.year_formed %></p>
  
  <%= link_to 'Edit', edit_band_path(@band) %> |
  <%= link_to 'Back', bands_path %>
  html
  Copy code
  <!-- app/views/bands/new.html.erb -->
  <h1>New Band</h1>
  
  <%= render 'form' %>
  
  <%= link_to 'Back', bands_path %>
  html
  Copy code
  <!-- app/views/bands/edit.html.erb -->
  <h1>Edit Band</h1>
  
  <%= render 'form' %>
  
  <%= link_to 'Show', @band %> |
  <%= link_to 'Back', bands_path %>
  html
  Copy code
  <!-- app/views/bands/_form.html.erb -->
  <%= form_with(model: @band, local: true) do |form
  
  
  
  
  