﻿/*
-----------------------------------------------------------------------------
This source file is part of VPET - Virtual Production Editing Tool
http://vpet.research.animationsinstitut.de/
http://github.com/FilmakademieRnd/VPET

Copyright (c) 2016 Filmakademie Baden-Wuerttemberg, Institute of Animation

This project has been realized in the scope of the EU funded project Dreamspace
under grant agreement no 610005.
http://dreamspaceproject.eu/

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU Lesser General Public License as published by the Free Software
Foundation; version 2.1 of the License.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 59 Temple
Place - Suite 330, Boston, MA 02111-1307, USA, or go to
http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html
-----------------------------------------------------------------------------
*/
using UnityEngine;
using UnityEngine.UI;
using System;

namespace vpet
{
	public class Elements
	{
		static public IMenuButton MenuButton()
		{
			GameObject refObjectPrefab = Resources.Load<GameObject>("VPET/Prefabs/ButtonTemplate");
			GameObject newButton = GameObject.Instantiate(refObjectPrefab);
			newButton.name = refObjectPrefab.name;
			newButton.GetComponent<RectTransform>().sizeDelta = UI.SpriteSize;
			MenuButton button = newButton.AddComponent<MenuButton>();
			button.interactable = false;
			return (IMenuButton)button;
		}
	
		static public IMenuButton MenuButtonToggle()
		{
			GameObject refObjectPrefab = Resources.Load<GameObject>("VPET/Prefabs/ButtonTemplate");
			GameObject newButton = GameObject.Instantiate(refObjectPrefab);
			newButton.name = refObjectPrefab.name;
			newButton.GetComponent<RectTransform>().sizeDelta = UI.SpriteSize;
			return (IMenuButton)newButton.AddComponent<MenuButtonToggle>();
		}

		static public IMenuButton MenuButtonList()
		{
			GameObject refObjectPrefab = Resources.Load<GameObject>("VPET/Prefabs/ButtonTemplate");
			GameObject newButton = GameObject.Instantiate(refObjectPrefab);
			newButton.name = refObjectPrefab.name;
			newButton.GetComponent<RectTransform>().sizeDelta = UI.SpriteSize;
			return (IMenuButton)newButton.AddComponent<MenuButtonList>();
		}

	}
}

