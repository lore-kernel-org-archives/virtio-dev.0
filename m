Return-Path: virtio-dev-return-2589-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id AB1D55818C66
	for <virtio-dev@lists.oasis-open.org>; Sat, 30 Sep 2017 21:08:32 -0700 (PDT)
Date: Sun, 1 Oct 2017 07:08:29 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171001063817-mutt-send-email-mst@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
 <D0158A423229094DA7ABF71CF2FA0DA34E1A46A6@SHSMSX152.ccr.corp.intel.com>
 <20170926011826-mutt-send-email-mst@kernel.org>
 <7A0DC0C9-F148-4161-B2D1-8D8D14D8B9A1@cisco.com>
 <20170928023112-mutt-send-email-mst@kernel.org>
 <D0158A423229094DA7ABF71CF2FA0DA34E1AD49B@SHSMSX152.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E1AD49B@SHSMSX152.ccr.corp.intel.com>
Subject: Re: [virtio-dev] packed ring layout proposal v3
To: "Liang, Cunming" <cunming.liang@intel.com>
Cc: "Steven Luong (sluong)" <sluong@cisco.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 28, 2017 at 09:44:35AM +0000, Liang, Cunming wrote:
> 
> Get it now. Please correct me if I missing something.
> 
> 
> Flags status hints,
> 
> - DESC_DRIVER only: driver owns the descriptor w/o available info ready for device to use
> 
> - DESC_DRIVER | DESC_WRAP: driver has prepared an available descriptor, device hasn't used it yet
> 
> - None: device has used the descriptor, and write descriptor out
> 
> - DESC_WRAP only: shall not happen, device make sure to clear it
> 
> 
> Polling behavior is,
> 
> - Device monitor DESC_WRAP bit set or not; If set, go to use descriptor and clear DESC_DRIVER bit in the end (note: always need to clear DESC_WRAP)
> 
> - Driver monitor DESC_DRIVER bit cleared or not; If cleared, reclaim descriptor(set DESC_DRIVER) and set DESC_WRAP once new available descriptor get ready to go
> 
> 
> --
> Steve


Hmm no, not what I had in mind.

DESC_DRIVER: used by driver to poll. Driver sets it when writing a
descriptor.  Device clears it when overwriting a descriptor.
Thus driver uses DESC_DRIVER to detect that device data in
descriptor is valid.



DESC_WRAP: used by device to poll. Driver sets it to a *different*
value every time it overwrites a descriptor. How to achieve it?
since descriptors are written out in ring order,
simply maintain the current value internally (start value 1) and flip it
every time you overwrite the first descriptor.
Device leaves it intact when overwriting a descriptor.


After writing down this explanation, I think the names aren't
great.



Let me try an alternative explanation.

---------------
A two-bit field, DRIVER_OWNER, signals the buffer ownership.
It has 4 possible values:
values 0x1, 0x11 are written by driver
values 0x0, 0x10 are written by device

each time driver writes out a descriptor, it must make sure
that the high bit in OWNER changes.

each time device writes out a descriptor, it must make sure
that the high bit in OWNER does not change.



this is exactly the same functionally, DRIVER is high bit and
WRAP is the low bit.  Does this make things clearer?
---------------



Maybe the difference between device and driver
is confusing. We can fix that by changing the values.
Here is an alternative. Let me know if you like it better -
I need to think a bit more to make sure it works,
but to give you an idea:


---------------
A two-bit field, DRIVER_OWNER, signals the buffer ownership.
It has 4 possible values:
values 0x1, 0x10 are written by driver
values 0x0, 0x11 are written by device

each time driver writes out a descriptor, it must make sure
that the high bit in OWNER changes. Thus first time
it writes 0x10, next time 0x1, then 0x10 again.

each time device writes out a descriptor, it must make sure
that the low bit in OWNER changes.  Thus first time
it writes 0x11, next time 0x0, then 0x11 again.

---------------



















> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Thursday, September 28, 2017 7:49 AM
> > To: Steven Luong (sluong)
> > Cc: Liang, Cunming; virtio-dev@lists.oasis-open.org;
> > virtualization@lists.linux-foundation.org
> > Subject: Re: [virtio-dev] packed ring layout proposal v3
> > 
> > On Tue, Sep 26, 2017 at 11:38:18PM +0000, Steven Luong (sluong) wrote:
> > > Michael,
> > >
> > > Would you please give an example or two how these two flags
> > DESC_DRIVER and DESC_WRAP are used together? Like others, I am
> > confused by the description and still don’t quite grok it.
> > >
> > > Steven
> > 
> > My bad, I will need to work on it. Here is an example:
> > 
> > Let's assume device promised to consume packets in order
> > 
> > ring size = 2
> > 
> > Ring is 0 initialized.
> > 
> > Device initially polls DESC[0].flags for WRAP bit to change.
> > 
> > driver adds:
> > 
> > DESC[0].addr = 1234
> > DESC[0].id = 0
> > DESC[0].flags = DESC_DRIVER | DESC_NEXT | DESC_WRAP
> > 
> > and
> > 
> > DESC[0].addr = 5678
> > DESC[1].id = 1
> > DESC[1].flags = DESC_DRIVER | DESC_WRAP
> > 
> > 
> > it now starts polling DESC[0] flags.
> > 
> > 
> > Device reads 1234, executes it, does not use it.
> > 
> > Device reads 5678, executes it, and uses it:
> > 
> > DESC[0].id = 1
> > DESC[0].flags = 0
> > 
> > Device now polls DESC[0].flags for WRAP bit to change.
> > 
> > Now driver sees that DRIVER bit has been cleared, so it nows that id is valid. I
> > sees id 1, therefore id 0 and 1 has been read and are safe to overwrite.
> > 
> > So it writes it out. It wrapped around to beginning of ring, so it flips the
> > WRAP bit to 0 on all descriptors now:
> > 
> > DESC[0].addr = 9ABC
> > DESC[0].id = 0
> > DESC[0].flags = DESC_DRIVER | DESC_NEXT
> > 
> > 
> > DESC[0].addr = DEF0
> > DESC[0].id = 1
> > DESC[0].flags = DESC_DRIVER
> > 
> > 
> > Next round wrap will be 1 again.
> > 
> > 
> > To summarise:
> > 
> > DRIVER bit is used by driver to detect device has used one or more
> > descriptors.  WRAP is is used by device to detect driver has made a new
> > descriptor available.
> > 
> > 
> > --
> > MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

