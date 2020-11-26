Return-Path: virtio-dev-return-7875-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E4140986358
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Nov 2020 09:58:45 +0000 (UTC)
Date: Thu, 26 Nov 2020 04:58:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20201126045340-mutt-send-email-mst@kernel.org>
References: <20200818115147.2567012-1-tomas.winkler@intel.com>
 <20200818115147.2567012-14-tomas.winkler@intel.com>
 <20201125160326-mutt-send-email-mst@kernel.org>
 <7f6181d8e80d4efb9464e9ec436800b7@intel.com>
MIME-Version: 1.0
In-Reply-To: <7f6181d8e80d4efb9464e9ec436800b7@intel.com>
Subject: [virtio-dev] Re: [char-misc-next 13/13] mei: virtio: virtualization frontend
 driver
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Usyskin, Alexander" <alexander.usyskin@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang, Yu1" <yu1.wang@intel.com>, "Liu, Shuo A" <shuo.a.liu@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 25, 2020 at 09:18:04PM +0000, Winkler, Tomas wrote:
> > 
> > On Tue, Aug 18, 2020 at 02:51:47PM +0300, Tomas Winkler wrote:
> > > +#ifndef VIRTIO_ID_MEI
> > > +#define VIRTIO_ID_MEI 0xFFFE /* virtio mei */ #endif
> > 
> > Just noticed now that this driver landed upstream.  Can I ask that you guys
> > please register IDs with the virtio TC and not just pick a number at random?
> > In particular this is way outside allowed range.
> > 
> > IDs should also be listed in include/uapi/linux/virtio_ids.h
> > 
> > If people just pick random numbers like this collistions are unavoidable.
> > 
> > List of IDs is part of virtio spec, chapter "Device Types".
> > 
> > Please do this change now before this goes out to production!
> Okay,  this was assigned by ACRN, my impression was it's already registered.
> Will take care of.
> Thanks
> Tomas

Found this:
https://projectacrn.github.io/latest/developer-guides/hld/hld-virtio-devices.html

Supported Virtio Devices
All the BE virtio drivers are implemented using the ACRN virtio APIs, and the FE drivers are reusing the standard Linux FE virtio drivers. For the devices with FE drivers available in the Linux kernel, they should use standard virtio Vendor ID/Device ID and Subsystem Vendor ID/Subsystem Device ID. For other devices within ACRN, their temporary IDs are listed in the following table.

Table 5 Virtio Devices without existing FE drivers in Linux
virtio device	Vendor ID	Device ID	Subvendor ID	Subdevice ID
RPMB	0x8086	0x8601	0x8086	0xFFFF
HECI	0x8086	0x8602	0x8086	0xFFFE
audio	0x8086	0x8603	0x8086	0xFFFD
IPU	0x8086	0x8604	0x8086	0xFFFC
TSN/AVB	0x8086	0x8605	0x8086	0xFFFB
hyper_dmabuf	0x8086	0x8606	0x8086	0xFFFA
HDCP	0x8086	0x8607	0x8086	0xFFF9
COREU	0x8086	0x8608	0x8086	0xFFF8
I2C	0x8086	0x860a	0x8086	0xFFF6
GPIO	0x8086	0x8609	0x8086	0xFFF7

so IIUC what you are using is a temporary ID which is fine for
experimentation but not for production.

Note it does take a couple of weeks for a TC to vote on reserving an ID
so pls do not delay this too much.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

