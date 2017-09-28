Return-Path: virtio-dev-return-2574-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 20A2958180EC
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 Sep 2017 14:13:36 -0700 (PDT)
Date: Fri, 29 Sep 2017 00:13:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170929001152-mutt-send-email-mst@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
 <D0158A423229094DA7ABF71CF2FA0DA34E1A46A6@SHSMSX152.ccr.corp.intel.com>
 <20170926011826-mutt-send-email-mst@kernel.org>
 <7A0DC0C9-F148-4161-B2D1-8D8D14D8B9A1@cisco.com>
 <20170928023112-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170928023112-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] packed ring layout proposal v3
To: "Steven Luong (sluong)" <sluong@cisco.com>
Cc: "Liang, Cunming" <cunming.liang@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 28, 2017 at 02:49:15AM +0300, Michael S. Tsirkin wrote:
> On Tue, Sep 26, 2017 at 11:38:18PM +0000, Steven Luong (sluong) wrote:
> > Michael,
> > 
> > Would you please give an example or two how these two flags DESC_DRIVER and DESC_WRAP are used together? Like others, I am confused by the description and still don’t quite grok it.
> > 
> > Steven

Note: I made a mistake in the email. Instead of DESC_NEXT it should read
DESC_MORE everywhere. I corrected the quoted text below for simplicity.



> My bad, I will need to work on it. Here is an example:
> 
> Let's assume device promised to consume packets in order
> 
> ring size = 2
> 
> Ring is 0 initialized.
> 
> Device initially polls DESC[0].flags for WRAP bit to change.
> 
> driver adds:
> 
> DESC[0].addr = 1234
> DESC[0].id = 0
> DESC[0].flags = DESC_DRIVER | DESC_MORE | DESC_WRAP
> 
> and
> 
> DESC[0].addr = 5678
> DESC[1].id = 1
> DESC[1].flags = DESC_DRIVER | DESC_WRAP
> 
> 
> it now starts polling DESC[0] flags.
> 
> 
> Device reads 1234, executes it, does not use it.
> 
> Device reads 5678, executes it, and uses it:
> 
> DESC[0].id = 1
> DESC[0].flags = 0
> 
> Device now polls DESC[0].flags for WRAP bit to change.
> 
> Now driver sees that DRIVER bit has been cleared, so it nows that id is
> valid. I sees id 1, therefore id 0 and 1 has been read and are safe to
> overwrite.
> 
> So it writes it out. It wrapped around to beginning of ring,
> so it flips the WRAP bit to 0 on all descriptors now:
> 
> DESC[0].addr = 9ABC
> DESC[0].id = 0
> DESC[0].flags = DESC_DRIVER | DESC_MORE
> 
> 
> DESC[0].addr = DEF0
> DESC[0].id = 1
> DESC[0].flags = DESC_DRIVER
> 
> 
> Next round wrap will be 1 again.
> 
> 
> To summarise:
> 
> DRIVER bit is used by driver to detect device has used one or more
> descriptors.  WRAP is is used by device to detect driver has made a
> new descriptor available.
> 
> 
> -- 
> MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

