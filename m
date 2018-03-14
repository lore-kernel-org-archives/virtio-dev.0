Return-Path: virtio-dev-return-3552-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A8705818F8C
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Mar 2018 08:31:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180314085601.GD28796@lst.de>
References: <20180313212508.3553.65326.stgit@localhost.localdomain>
 <20180313213054.3553.89366.stgit@localhost.localdomain> <20180314085601.GD28796@lst.de>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 14 Mar 2018 08:31:24 -0700
Message-ID: <CAKgT0UcotCGAQZjT8SWp0+HeHasyt0UV8M_Ev_zi08jV1uvp8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [pci PATCH v6 5/5] pci-pf-stub: Add PF driver stub for PFs that
 function only to enable VFs
To: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, Netdev <netdev@vger.kernel.org>, "Daly, Dan" <dan.daly@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>, netanel@amazon.com, Don Dutile <ddutile@redhat.com>, Maximilian Heyne <mheyne@amazon.de>, "Wang, Liang-min" <liang-min.wang@intel.com>, "Rustad, Mark D" <mark.d.rustad@intel.com>, David Woodhouse <dwmw2@infradead.org>, dwmw@amazon.co.uk
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 14, 2018 at 1:56 AM, Christoph Hellwig <hch@lst.de> wrote:
>> +
>> +/**
>> + * pci_pf_stub_white_list - White list of devices to bind pci-pf-stub onto
>> + *
>> + * This table provides the list of IDs this driver is supposed to bind
>> + * onto. You could think of this as a list of "quirked" devices where we
>> + * are adding support for SR-IOV here since there are no other drivers
>> + * that they would be running under.
>> + *
>> + * Layout of the table below is as follows:
>> + * { Vendor ID, Device ID,
>> + *   SubVendor ID, SubDevice ID,
>> + *   Class, Class Mask,
>> + *   private data (not used) }
>> + */
>
> No need to document the PCI device table format in a random driver.

I realize this probably isn't necessary, but I wanted to document it
to make it clear in terms of layout so that it is't confused with the
quirk structure layout since this has been referred to as a "quirk"
driver a few times.

> Otherwise looks fine:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

