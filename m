Return-Path: virtio-dev-return-7129-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EBCD7985359
	for <virtio-dev@lists.oasis-open.org>; Mon, 20 Apr 2020 05:33:41 +0000 (UTC)
References: <BN6PR1801MB2067FCCE45316C25E5EB82F7C5DA0@BN6PR1801MB2067.namprd18.prod.outlook.com>
 <20200414121724-mutt-send-email-mst@kernel.org>
 <6cd6b9aa-1ee8-d523-aee3-4765dc52202e@redhat.com>
 <6bd9fd2b-b3c8-2267-18fd-0ad29cf92020@redhat.com>
 <20200417023805-mutt-send-email-mst@kernel.org>
 <03aa8c83-ed50-9004-25d1-21cdc090d6c3@redhat.com>
 <20200417053429-mutt-send-email-mst@kernel.org>
 <725d5f08-de6c-e918-7df3-6c9fc6c31a27@redhat.com>
 <20200417060640-mutt-send-email-mst@kernel.org>
 <f13ee7bf-80e2-c23b-e3a6-159a12b257ff@redhat.com>
 <20200417062938-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3d49e58f-76f1-557d-146f-c871fed74a78@redhat.com>
Date: Mon, 20 Apr 2020 13:33:27 +0800
MIME-Version: 1.0
In-Reply-To: <20200417062938-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [Virtio-networking] Doorbell mapping of vDPA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Vitaly Mireyno <vmireyno@marvell.com>, "virtio-networking@redhat.com" <virtio-networking@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Ariel Elior <aelior@marvell.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/4/17 =E4=B8=8B=E5=8D=887:00, Michael S. Tsirkin wrote:
>> Two more questions.
>>
>> 1) If the doorbell of control vq shares 64K pages with other doorbell, t=
hen
>> we can't intercept the control vq doorbell by software.
> And if hardware requires doorbell e.g. at offset 0x10 in the page,
> we can't migrate to a device which needs it at offset 0x0.


We can fallback to eventfd based relay in this case, but it looks more=20
complicated.

So it's probably more realistic to support the page-per-vq model as the=20
first step.

Thanks



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

