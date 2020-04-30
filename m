Return-Path: virtio-dev-return-7224-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BFE24985B07
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Apr 2020 13:00:06 +0000 (UTC)
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck> <20200430103446.GH5097@quicinc.com>
 <20200430104149.GG19932@willie-the-truck> <20200430111156.GI5097@quicinc.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7bf8bffe-267b-6c66-86c9-40017d3ca4c2@siemens.com>
Date: Thu, 30 Apr 2020 14:59:50 +0200
MIME-Version: 1.0
In-Reply-To: <20200430111156.GI5097@quicinc.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>, Will Deacon <will@kernel.org>
Cc: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com, stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 30.04.20 13:11, Srivatsa Vaddagiri wrote:
> * Will Deacon <will@kernel.org> [2020-04-30 11:41:50]:
>=20
>> On Thu, Apr 30, 2020 at 04:04:46PM +0530, Srivatsa Vaddagiri wrote:
>>> If CONFIG_VIRTIO_MMIO_OPS is defined, then I expect this to be uncondit=
ionally
>>> set to 'magic_qcom_ops' that uses hypervisor-supported interface for IO=
 (for
>>> example: message_queue_send() and message_queue_recevie() hypercalls).
>>
>> Hmm, but then how would such a kernel work as a guest under all the
>> spec-compliant hypervisors out there?
>=20
> Ok I see your point and yes for better binary compatibility, the ops have=
 to be
> set based on runtime detection of hypervisor capabilities.
>=20
>>> Ok. I guess the other option is to standardize on a new virtio transpor=
t (like
>>> ivshmem2-virtio)?
>>
>> I haven't looked at that, but I suppose it depends on what your hypervis=
or
>> folks are willing to accomodate.
>=20
> I believe ivshmem2_virtio requires hypervisor to support PCI device emula=
tion
> (for life-cycle management of VMs), which our hypervisor may not support.=
 A
> simple shared memory and doorbell or message-queue based transport will w=
ork for
> us.

As written in our private conversation, a mapping of the ivshmem2 device=20
discovery to platform mechanism (device tree etc.) and maybe even the=20
register access for doorbell and life-cycle management to something=20
hypercall-like would be imaginable. What would count more from virtio=20
perspective is a common mapping on a shared memory transport.

That said, I also warned about all the features that PCI already defined=20
(such as message-based interrupts) which you may have to add when going=20
a different way for the shared memory device.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

