Return-Path: virtio-dev-return-7015-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE166985E77
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Apr 2020 09:53:25 +0000 (UTC)
MIME-Version: 1.0
References: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com>
 <20200309030251-mutt-send-email-mst@kernel.org> <ff63b1e2-e4aa-1b13-0b4a-72fd23badc06@redhat.com>
 <20200309060238-mutt-send-email-mst@kernel.org> <fdedf8ac-74ed-f502-daef-38896f23e526@redhat.com>
 <20200310021729-mutt-send-email-mst@kernel.org> <89358cf3-7ce0-7b60-f4a7-2672970a635e@redhat.com>
 <CAJPjb1Jg3Md7GrzAG2-6hJk4YwmpkqDCLFWMpXrvvkUY=5pMpQ@mail.gmail.com> <0f43a280-5425-3a10-1312-22ea87d320ca@redhat.com>
In-Reply-To: <0f43a280-5425-3a10-1312-22ea87d320ca@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 7 Apr 2020 11:52:46 +0200
Message-ID: <CAJaqyWfeSgj=+RMM_Zy4gTAkNJ42Ax5Axvc8okHOhH7UTsxhaA@mail.gmail.com>
Subject: Re: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Rob Miller <rob.miller@broadcom.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>, Juan Quintela <quintela@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi!

So, from the previous mails, it seems that monitoring the used ring
(and the packed descriptors) is a good first step in that direction,
as DPDK did. This way, the device does not need to worry about the
dirty page tracking using a bitmap and the PCI writes limitation, and
we can evaluate later the proposed alternatives:
* Alternate used descriptors in packed.
* vDPA interface for vDPA devices in a convenient format.

Any thoughts? Do you think that we should start with another way?

Thanks!


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

