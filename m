Return-Path: virtio-dev-return-5636-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 812C6985C90
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Mar 2019 00:47:34 +0000 (UTC)
Date: Tue, 26 Mar 2019 06:18:01 +0530
From: vlse <vlse@veera.biz>
Message-ID: <20190326004759.GD1872@localhost>
References: <20190324043339.GA1884@localhost> <20190324045118.GC1916@localhost> <60d7d47b-7ece-fe13-1784-831394807018@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60d7d47b-7ece-fe13-1784-831394807018@redhat.com>
Subject: Re: [virtio-dev] Would there be virtio-audio spec in future for clean audio interface
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Mar 25, 2019 at 02:13:51PM +0100, Paolo Bonzini wrote:
> On 24/03/19 05:51, vlse wrote:
> > Would there be virtio-audio spec in future for clean audio interface?
> > 
> > Projectacrn.github.io provides one virtio-audio interface for automotive sytems.
> 
> That's interesting to know.  It would probably be up to projectacrn to
> submit virtio-audio to the committee, or at least reserve the device
> number. Do you have a contact at projectacrn that can help with this?
> 
> Thanks,
> 
> Paolo

Hi,

No I don't have a contact with Project ACRN.

ACRN is a Linux Foundation Project. Initially it was by Intel.
It is a hypervisor for embedded devices.
Website is https://projectacrn.org/.

Their supported virtio-audio details:
 Vendor ID: 0x8086
 Device ID: 0x8603
 Subvendor ID: 0x8086
 Subdevice ID: 0xFFFD

Another implementation from another developer from Intel.
Website: https://patchwork.freedesktop.org/patch/174013/
Author: Luo Xionghu <xionghu.luo@intel.com>

Comments by Author: this patch only add audio device pci registration.
                    need add audio part to call audio Backend driver later.

Regards,
Veera

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

