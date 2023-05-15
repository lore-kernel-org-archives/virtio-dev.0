Return-Path: <virtio-dev-return-12674-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3677C7EE24
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 05:08:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 21401157F04
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 05:08:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 19B859865A6
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 05:08:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0809B983E49; Mon, 15 May 2023 05:08:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E458498635A
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 May 2023 05:08:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: A7ZaDm5FMeeJTFV8h1H-tQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684127311; x=1686719311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIPnVUjkeM8f3D/OMO1tEou23QrJiOMOp2FZ8sNXd5A=;
        b=HhQYc816FHprx+TawgNWbN+crcLapyVuLlUOcrhAC4W2I1yAxRmhAvcbUGDbXlv1mH
         GCONAYm5tY9iVpDu4w+EsHnMEa1BPEKeqd9rBGfiQbL93VKNd2i51JmuLgrt1dyaAPV9
         pPHXwuVtbRJxltXoXoNTet1GwMV2FzE6+spNf3kPq0USAPxD+enCVC60YRkiO3efm1IK
         jbwXoyDmucw1bAB67vfE2c+2edFbWiFKZ+v3o7Am+XdivCkD8x+CmOeZl8UfIIEAAgyp
         rjZJtlTRtvCpYS5p5P2SlUCuCC9D8Ly3CRIsGMv1ZzGDZML0ElrFWRyqSmjtP8ji9O/z
         GQlA==
X-Gm-Message-State: AC+VfDyr8WVrhpmQ0UNkcdDcu5VUmr19epxK+O4wGBhmM3+HakBoJyJp
	HhPSqfRQkHnQRonUNMmLS1/lXrVY+N5gHrfBCWqaSoWXE7W1p1rtLOH46OcDzMAXjrjbADh6oAg
	aD4I/yBlk/Ro1nYMDebqLMUaPfYnx
X-Received: by 2002:a05:6a00:15c6:b0:635:d9e1:8e1e with SMTP id o6-20020a056a0015c600b00635d9e18e1emr47409592pfu.11.1684127310736;
        Sun, 14 May 2023 22:08:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7+CkTSe9s1okB6VWI7k13+/Yor+9YTGDQQMyksYFlzI8jNo9RjQI0VRdB8FjdQcieks3fVbg==
X-Received: by 2002:a05:6a00:15c6:b0:635:d9e1:8e1e with SMTP id o6-20020a056a0015c600b00635d9e18e1emr47409572pfu.11.1684127310379;
        Sun, 14 May 2023 22:08:30 -0700 (PDT)
Message-ID: <8f5da3f3-d617-4a14-b9b9-e378b5a9ccb2@redhat.com>
Date: Mon, 15 May 2023 13:08:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "david.edmondson@oracle.com" <david.edmondson@oracle.com>,
 "sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas
 <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Shahaf Shuler <shahafs@nvidia.com>
References: <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <b33fe999-8491-30b4-5021-589a2fe87398@nvidia.com>
 <CACGkMEsSJVG8mzuo3BH1xQzz5TyNbO+o3GcYwoXchcYVOczTTg@mail.gmail.com>
 <PH0PR12MB5481AC52CCAE9636E17C7565DC769@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu1oU0wzygicS0bApoWuRaWkWsPivKRiq-ghezB=hg+Fw@mail.gmail.com>
 <CACGkMEuqGtJP3vXoHrXOBgvPz3woo900+U9kYX1xZnM5h_qXWg@mail.gmail.com>
 <03c8f7ca-8235-a5a7-5367-b6fd59ad0447@nvidia.com>
 <CACGkMEv3XBXB_i_PUwxgvY8_UWipGVu8xuGQATp+kHOx3Vdnsg@mail.gmail.com>
 <20230511073218-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230511073218-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ


在 2023/5/11 19:35, Michael S. Tsirkin 写道:
> On Thu, May 11, 2023 at 03:20:52PM +0800, Jason Wang wrote:
>> On Thu, May 11, 2023 at 12:08 AM Parav Pandit <parav@nvidia.com> wrote:
>>>
>>>
>>> On 5/10/2023 12:22 AM, Jason Wang wrote:
>>>> On Wed, May 10, 2023 at 11:51 AM Jason Wang <jasowang@redhat.com> wrote:
>>>> Just to make sure we are at the same page.
>>>>
>>>> 1) if the hardware has configq and we need to make it work for current
>>>> virtio-pci driver, hypervisor needs to trap guest PCI access and
>>>> translate it to configq command. This means the hypervisor needs to
>>>> hide the configq from guests. In this case the configq needs a
>>>> dedicated DMA address which is what PASID can help.
>>>> 2) if the hardware can report the device states, unless we want to
>>>> migrate L2 guest, hypervisor should hide it from L1, so PASID is
>>>> required to isolate the DMA for guest traffic and device state.
>>> A configq negotiates + discovers new fields for the PCI PF, VF, SF/SIOV
>>> devices over PCIe or other transports.
>>> So no need to hide/mediate for hw based devices, like cvq and like data vqs.
>> As discussed, I may misunderstand the function of the configq. If it
>> works like cvq, then yes. We don't need PASID.
>>
>> But if we want to report device state via let's say migration q, it
>> requires PASID since it is used by the hypervisor.
>>
>> Thanks
> I don't exactly get this part. With SRIOV migration q normally would be
> part of the PF, accessing hypervisor memory.


Yes, I meant if we have a per VF adminq.

Thanks


>
>
>
>
>
>>> For vdpa kind of use case it can work like cvq mediation, which I
>>> believe is happening without PASID today.
>>>
>>> This publicly archived list offers a means to provide input to the
>>> OASIS Virtual I/O Device (VIRTIO) TC.
>>>
>>> In order to verify user consent to the Feedback License terms and
>>> to minimize spam in the list archive, subscription is required
>>> before posting.
>>>
>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>>> List help: virtio-comment-help@lists.oasis-open.org
>>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>>> Committee: https://www.oasis-open.org/committees/virtio/
>>> Join OASIS: https://www.oasis-open.org/join/
>>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

