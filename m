Return-Path: virtio-dev-return-5637-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4570D985C90
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Mar 2019 09:38:45 +0000 (UTC)
References: <20190324043339.GA1884@localhost>
 <20190324045118.GC1916@localhost>
 <60d7d47b-7ece-fe13-1784-831394807018@redhat.com>
 <20190326004759.GD1872@localhost>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2541c721-0b13-3c41-7a94-2fd8fe1ad640@redhat.com>
Date: Tue, 26 Mar 2019 10:38:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190326004759.GD1872@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Would there be virtio-audio spec in future for clean
 audio interface
To: vlse <vlse@veera.biz>
Cc: virtio-dev@lists.oasis-open.org, xionghu.luo@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 26/03/19 01:48, vlse wrote:
> On Mon, Mar 25, 2019 at 02:13:51PM +0100, Paolo Bonzini wrote:
> Hi,
> 
> No I don't have a contact with Project ACRN.
> 
> ACRN is a Linux Foundation Project. Initially it was by Intel.
> It is a hypervisor for embedded devices.
> Website is https://projectacrn.org/.
> 
> Their supported virtio-audio details:
>  Vendor ID: 0x8086
>  Device ID: 0x8603
>  Subvendor ID: 0x8086
>  Subdevice ID: 0xFFFD
> 
> Another implementation from another developer from Intel.
> Website: https://patchwork.freedesktop.org/patch/174013/
> Author: Luo Xionghu <xionghu.luo@intel.com>
> 
> Comments by Author: this patch only add audio device pci registration.
>                     need add audio part to call audio Backend driver later.

Thanks, that's useful.  Xionghu, is there a public spec for
virtio-audio, and/or does Intel intend to contribute it to the virtio
specification?

Unfortunately device id 21 is already taken.  I'll send a patch to the
specification that reserves id 25 for virtio-audio.

Thanks,

Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

