Return-Path: virtio-dev-return-4708-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A3D77985C4C
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Jul 2018 15:12:47 +0000 (UTC)
MIME-Version: 1.0
In-Reply-To: <CA+sq2CdDuimDCYK+9arO7-oRpNxdynX+rqYwpeBi9C_R+4pQNw@mail.gmail.com>
References: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com>
 <20180420163109.46077.60334.stgit@ahduyck-green-test.jf.intel.com> <CA+sq2CdDuimDCYK+9arO7-oRpNxdynX+rqYwpeBi9C_R+4pQNw@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 19 Jul 2018 08:12:45 -0700
Message-ID: <CAKgT0UcTn=fxhrTvAaJNbGFiKPyZ-MaK0T6+AJewFs6YzDvT0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [pci PATCH v8 4/4] pci-pf-stub: Add PF driver stub for PFs that
 function only to enable VFs
To: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci <linux-pci@vger.kernel.org>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, Linux Netdev List <netdev@vger.kernel.org>, "Daly, Dan" <dan.daly@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>, netanel@amazon.com, Don Dutile <ddutile@redhat.com>, Maximilian Heyne <mheyne@amazon.de>, "Wang, Liang-min" <liang-min.wang@intel.com>, "Rustad, Mark D" <mark.d.rustad@intel.com>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>, dwmw@amazon.co.uk
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jul 19, 2018 at 3:52 AM, Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> Hi,
>
>> +static struct pci_driver pf_stub_driver = {
>> +       .name                   = "pci-pf-stub",
>> +       .id_table               = pci_pf_stub_white_list,
>> +       .probe                  = pci_pf_stub_probe,
>> +       .sriov_configure        = pci_sriov_configure_simple,
>> +};
>> +
>
> Is there any specific reason for not disabling SRIOV upon driver unload/remove ?
>
> i.e if a user sets numVFs to a non-zero value and unloads this driver
> then we have a
> situation where there is no PF driver in kernel but VFs still exist.
>
> Thanks,
> Sunil.

I think it was probably just an oversight on my part. Feel free to
submit a patch to disable SR-IOV on remove and I will give it a quick
review/ack assuming the code itself is fine.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

