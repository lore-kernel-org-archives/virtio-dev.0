Return-Path: virtio-dev-return-3525-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 94FEE5818F5D
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Mar 2018 07:51:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1520928772.28745.53.camel@infradead.org>
References: <20180312171813.3487.94803.stgit@localhost.localdomain>
 <20180312172309.3487.76690.stgit@localhost.localdomain> <1520928772.28745.53.camel@infradead.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 13 Mar 2018 07:51:33 -0700
Message-ID: <CAKgT0UdkUSsHQC7CpJQ0CT77AD8k7P-HeeomWXNJQ-Ek4dJRMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [pci PATCH v5 3/4] ena: Migrate over to unmanaged SR-IOV support
To: David Woodhouse <dwmw2@infradead.org>, Don Dutile <ddutile@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, Netdev <netdev@vger.kernel.org>, "Daly, Dan" <dan.daly@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>, netanel@amazon.com, Maximilian Heyne <mheyne@amazon.de>, "Wang, Liang-min" <liang-min.wang@intel.com>, "Rustad, Mark D" <mark.d.rustad@intel.com>, Christoph Hellwig <hch@lst.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Mar 13, 2018 at 1:12 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Mon, 2018-03-12 at 10:23 -0700, Alexander Duyck wrote:
>>
>> -       .sriov_configure = ena_sriov_configure,
>> +#ifdef CONFIG_PCI_IOV
>> +       .sriov_configure = pci_sriov_configure_simple,
>> +#endif
>>  };
>
> I'd like to see that ifdef go away, as discussed. I agree that just
> #define pci_sriov_configure_simple NULL
> should suffice. As Christoph points out, it's not going to compile if
> people try to just invoke it directly.
>
> I'd also *really* like to see a way to enable this for PFs which don't
> have (and don't need) a driver. We seem to have lost that along the
> way.

Actually the suggestion I had from Don Dutile was that we should be
looking at creating a pci-stub like driver specifically for those type
of devices, but without the ability to arbitrarily assign devices.
Basically we have to white-list it in one device at a time for those
kind of things.

If you have the device ID of the thing you wanted to have work with
pci-stub before I could look at putting together a quick driver and
adding it to this set.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

