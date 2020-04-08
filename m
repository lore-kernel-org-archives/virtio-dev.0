Return-Path: virtio-dev-return-7020-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7F49C985EF2
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Apr 2020 10:01:10 +0000 (UTC)
Date: Wed, 8 Apr 2020 06:00:51 -0400 (EDT)
From: Jason Wang <jasowang@redhat.com>
Message-ID: <123421885.21147407.1586340051693.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAJPjb1KijQN39gC=8_hzBrt9zo0aX2uFAdPA7ynkmUv2bMFtEA@mail.gmail.com>
References: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com> <fdedf8ac-74ed-f502-daef-38896f23e526@redhat.com> <20200310021729-mutt-send-email-mst@kernel.org> <89358cf3-7ce0-7b60-f4a7-2672970a635e@redhat.com> <CAJPjb1Jg3Md7GrzAG2-6hJk4YwmpkqDCLFWMpXrvvkUY=5pMpQ@mail.gmail.com> <0f43a280-5425-3a10-1312-22ea87d320ca@redhat.com> <CAJaqyWfeSgj=+RMM_Zy4gTAkNJ42Ax5Axvc8okHOhH7UTsxhaA@mail.gmail.com> <CAJPjb1KijQN39gC=8_hzBrt9zo0aX2uFAdPA7ynkmUv2bMFtEA@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Rob Miller <rob.miller@broadcom.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tsirkin <mst@redhat.com>, Juan Quintela <quintela@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

----- Original Message -----
> another question on vDPA vs vendor specific driver portion...
> 
> Are the subsystem vendor & device IDs to be different from the primary (Red
> Hat) versions as there has to be a way for a vendor specific driver to
> "see" its device.

Yes, any kinds of (PCI)device could be registered to the vDPA bus. For PCI
driver, it supports exact mathing based on subsystem ID.

E.g in IFCVF driver it does:

static struct pci_device_id ifcvf_pci_ids[] = {
	{ PCI_DEVICE_SUB(IFCVF_VENDOR_ID,
		IFCVF_DEVICE_ID,
		IFCVF_SUBSYS_VENDOR_ID,
		IFCVF_SUBSYS_DEVICE_ID) },
	{ 0 },
};

Which uses Redhat primary vendor ID but their own sybsysm
vendor/device ID.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

