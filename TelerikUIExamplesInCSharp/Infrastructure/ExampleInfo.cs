using System;
using System.Collections.Generic;

using Foundation;
using UIKit;

namespace Examples
{
	public class ExampleInfo
	{
		public ExampleInfo[] Examples { get; set; }

		public string Title { get; set; }

		public Type ExampleType { get; set; }

		public ExampleInfo (string title, ExampleInfo[] examples)
		{
			this.Title = title;
			this.Examples = examples;
		}

		public ExampleInfo (string title, Type exampleType)
		{
			this.Title = title;
			this.ExampleType = exampleType;
		}

		public UIViewController CreateViewController()
		{
			UIViewController controller = Examples != null ? new ViewController (Examples) : (UIViewController)Activator.CreateInstance (ExampleType);
			controller.Title = this.Title;
			return controller;
		}
	}
}

