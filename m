Return-Path: virtio-dev-return-6582-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD27E985CB0
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Jan 2020 09:13:02 +0000 (UTC)
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <85eeab19-1f53-6c45-95a2-44c1cfd39184@redhat.com>
 <28da67db-73ab-f772-fb00-5a471b746fc5@linux.intel.com>
 <683cac51-853d-c8c8-24c6-b01886978ca4@redhat.com>
 <42346d41-b758-967a-30b7-95aa0d383beb@linux.intel.com>
 <0c3d33de-3940-7895-2fe2-81de8714139c@redhat.com>
 <46806720-1D1C-40C3-BEE2-EDB0D4DA39BF@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7e151886-408e-2c1d-3958-77c26b8a4ac0@redhat.com>
Date: Fri, 3 Jan 2020 17:12:38 +0800
MIME-Version: 1.0
In-Reply-To: <46806720-1D1C-40C3-BEE2-EDB0D4DA39BF@linux.alibaba.com>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for
 virtio-mmio specification version 3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Liu, Jiang" <gerry@linux.alibaba.com>
Cc: "Liu, Jing2" <jing2.liu@linux.intel.com>, Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org, mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/1/3 =E4=B8=8B=E5=8D=882:14, Liu, Jiang wrote:
>> Ok, I get you now.
>>
>> But still, having fixed number of MSIs is less flexible. E.g:
>>
>> - for x86, processor can only deal with about 250 interrupt vectors.
>> - driver may choose to share MSI vectors [1] (which is not merged but we=
 will for sure need it)
> Thanks for the info:)
> X86 systems roughly have NCPU * 200 vectors available for device interrup=
ts.
> The proposed patch tries to map multiple event sources to an interrupt ve=
ctor, to avoid running out of x86 CPU vectors.
> Many virtio mmio devices may have several or tens of event sources, and i=
t=E2=80=99s rare to have hundreds of event sources.
> So could we treat the dynamic mapping between event sources and interrupt=
 vectors as an advanced optional feature?
>

Maybe, but I still prefer to implement it if it is not too complex.=20
Let's see Michael's opinion on this.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

