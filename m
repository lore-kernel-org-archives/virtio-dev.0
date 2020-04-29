Return-Path: virtio-dev-return-7206-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 52772985E7F
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Apr 2020 10:56:17 +0000 (UTC)
References: <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
 <20200429094410.GD5097@quicinc.com>
 <20200429055125-mutt-send-email-mst@kernel.org>
 <20200429100953.GE5097@quicinc.com>
 <20200429061621-mutt-send-email-mst@kernel.org>
 <f52556e2-253e-2dbc-cb7a-a7991e3bcfde@siemens.com>
 <20200429064458-mutt-send-email-mst@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <303ace66-950c-955d-d750-74de5054788a@siemens.com>
Date: Wed, 29 Apr 2020 12:55:56 +0200
MIME-Version: 1.0
In-Reply-To: <20200429064458-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH 5/5] virtio: Add bounce DMA ops
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srivatsa Vaddagiri <vatsa@codeaurora.org>, Lu Baolu <baolu.lu@linux.intel.com>, tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com, jasowang@redhat.com, christoffer.dall@arm.com, virtualization@lists.linux-foundation.org, alex.bennee@linaro.org, iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com, will@kernel.org, linux-kernel@vger.kernel.org, pratikp@codeaurora.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 29.04.20 12:45, Michael S. Tsirkin wrote:
> On Wed, Apr 29, 2020 at 12:26:43PM +0200, Jan Kiszka wrote:
>> On 29.04.20 12:20, Michael S. Tsirkin wrote:
>>> On Wed, Apr 29, 2020 at 03:39:53PM +0530, Srivatsa Vaddagiri wrote:
>>>> That would still not work I think where swiotlb is used for pass-thr d=
evices
>>>> (when private memory is fine) as well as virtio devices (when shared m=
emory is
>>>> required).
>>>
>>> So that is a separate question. When there are multiple untrusted
>>> devices, at the moment it looks like a single bounce buffer is used.
>>>
>>> Which to me seems like a security problem, I think we should protect
>>> untrusted devices from each other.
>>>
>>
>> Definitely. That's the model we have for ivshmem-virtio as well.
>>
>> Jan
>=20
> Want to try implementing that?
>=20

The desire is definitely there, currently "just" not the time.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

