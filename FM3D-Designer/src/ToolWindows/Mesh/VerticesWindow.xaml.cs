﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace FM3D_Designer.src.ToolWindows.Mesh
{
    /// <summary>
    /// Interaction logic for VerticesWindow.xaml
    /// </summary>
    public partial class VerticesWindow : ToolWindow
    {
        public VerticesWindow(WindowLayouts.MeshLayout layout)
        {
            InitializeComponent();

            this.grid.DataContext = layout;
        }

        private void ToolWindow_Closed(object sender, RoutedEventArgs e)
        {
            this.grid.ItemsSource = null;
        }
    }
}
