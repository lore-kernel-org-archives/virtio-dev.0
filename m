Return-Path: virtio-dev-return-3978-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E432D581806A
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Apr 2018 17:09:47 -0700 (PDT)
Date: Fri, 27 Apr 2018 03:09:36 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180427024347-mutt-send-email-mst@kernel.org>
References: <1524700768-38627-1-git-send-email-sridhar.samudrala@intel.com>
 <1524700768-38627-5-git-send-email-sridhar.samudrala@intel.com>
 <20180425170837.6520a577@xeon-e3>
 <20180426052908-mutt-send-email-mst@kernel.org>
 <20180426153326.16388dfd@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426153326.16388dfd@xeon-e3>
Subject: [virtio-dev] Re: [PATCH net-next v8 4/4] netvsc: refactor notifier/event handling
 code to use the failover framework
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 26, 2018 at 03:33:26PM -0700, Stephen Hemminger wrote:
> On Thu, 26 Apr 2018 05:30:05 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Apr 25, 2018 at 05:08:37PM -0700, Stephen Hemminger wrote:
> > > On Wed, 25 Apr 2018 16:59:28 -0700
> > > Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> > >   
> > > > Use the registration/notification framework supported by the generic
> > > > failover infrastructure.
> > > > 
> > > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>  
> > > 
> > > NAK unless you prove this works on legacy distributions and with DPDK 18.05
> > > without modification.  
> > 
> > It looks like it should work. What kind of proof are you looking for?
> > 
> 
> 
> I tried this with working Ubuntu 17 on WS2016.
> It boots if the failover driver is configured in (as module).

Oh so by "unless you prove" you meant "unless you test"?

> But if the configuration has:
> 
> $ grep FAILOVER .config
> # CONFIG_NET_FAILOVER is not set
> CONFIG_MAY_USE_NET_FAILOVER=y

So the new option works, what's broken is when it's *not* selected.
Looks like a bug.

> The netvsc driver fails on boot with:
> 
> [    0.826447] hv_vmbus: registering driver hv_netvsc
> [    0.829616] scsi 0:0:0:0: Direct-Access     Msft     Virtual Disk     1.0  PQ: 0 ANSI: 5
> [    0.836291] input: Microsoft Vmbus HID-compliant Mouse as /devices/0006:045E:0621.0001/input/input1
> [    0.839139] hid-generic 0006:045E:0621.0001: input: <UNKNOWN> HID v0.01 Mouse [Microsoft Vmbus HID-compliant Mouse] on
> [    0.964897] hv_vmbus: probe failed for device 849a776e-8120-4e4a-9a36-7e3d95ac75b3 (-95)
> [    0.968039] hv_netvsc: probe of 849a776e-8120-4e4a-9a36-7e3d95ac75b3 failed with error -95
> [    1.112877] hv_vmbus: probe failed for device 53557f8e-057d-425b-9265-01c0fd7e273e (-95)
> [    1.116064] hv_netvsc: probe of 53557f8e-057d-425b-9265-01c0fd7e273e failed with error -95
> 
> The system has two virtual networks. eth0 is on vswitch for management.
> eth1 is on vswitch with SR-IOV for performance tests.
> 
> You probably need to just put the failover part in net/core and select it.

From all drivers. Yes. And it does not need to be visible in the menu
imho.


> It is trivial to get an evaluation version of Windows Server 2016 and setup a Linux VM.
> Please try it.

I presume some kind of test was done here. Sridhar, do you think you
could include some notes about testing of this patch? Or in case you
only build-tested this part, it's a good idea to notice this after ---
in the patch, or in the cover letter.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

