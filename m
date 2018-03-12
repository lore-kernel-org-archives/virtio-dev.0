Return-Path: virtio-dev-return-3511-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D8A55818036
	for <virtio-dev@lists.oasis-open.org>; Mon, 12 Mar 2018 09:02:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312075907.GA5342@lst.de>
References: <20180308185507.5433.98830.stgit@localhost.localdomain>
 <20180308190047.5433.77952.stgit@localhost.localdomain> <20180311215909.16ed4bf1@t450s.home>
 <20180312075907.GA5342@lst.de>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 12 Mar 2018 09:01:54 -0700
Message-ID: <CAKgT0UcJz7go-vRd88M6uo1mqbG9BfedkZmR0CXZ92m6KfRPzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [pci PATCH v4 1/4] pci-iov: Add support for unmanaged SR-IOV
To: Christoph Hellwig <hch@lst.de>
Cc: Alex Williamson <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, Netdev <netdev@vger.kernel.org>, "Daly, Dan" <dan.daly@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, keith.busch@intel.com, netanel@amazon.com, Maximilian Heyne <mheyne@amazon.de>, "Wang, Liang-min" <liang-min.wang@intel.com>, "Rustad, Mark D" <mark.d.rustad@intel.com>, David Woodhouse <dwmw2@infradead.org>, dwmw@amazon.co.uk
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Mar 12, 2018 at 12:59 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Sun, Mar 11, 2018 at 09:59:09PM -0600, Alex Williamson wrote:
>> I still struggle to understand why we need this "unmanaged"
>> complication and how a user of the sysfs API is expected to have any
>> idea whether a PF is managed or unmanaged and why they should care.
>> Can't we just have a pci_simple_sriov_configure() helper and ignore
>> this unmanaged business?  Thanks,
>
> Just a pci_simple_sriov_configure is exactly what I envisioned originally.

I can drop the "unmanaged" bits if that is what is wanted, but based
on previous conversations I thought there was some concern about the
kernel loading VFs when there was some foreign entity managing the VFs
other than the kernel.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

