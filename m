Return-Path: <virtio-dev-return-12676-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D57EC77B75
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 05:20:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 974BE29FC5
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 05:20:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79E3098636A
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 05:20:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 63EBC983E49; Mon, 15 May 2023 05:20:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 23268986348
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 May 2023 05:20:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: EsbBLJfiOA6_Mak5ZcX7qg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684128003; x=1686720003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3iVMrfkIQupC947aM1Wx9OGzqmu3lEXS8gyYURuKVuA=;
        b=f+LXXTvVnWjz29x9NuD/erknhlZeBkySC4khm6Kkxu6dmEFzVDGentqy9hw+fLNEMG
         B32JDw5ZdqFDIpHw4QOONiUxdoHG3Mn6RuTVu95SNfraa4rXZBai1yrvR9N96BufFaYd
         bInDurBWr0ntLdkxSzMfVRjEfSERF34gUGgj6rlNNciM7wciRKzM+ZH029LwoK4CBZUT
         JQUhbwQVowzLu6t8AZYnmL5I7q11/tkg/IZtJLh31Ef/DgHO7MoQiHV+uXy8kn1nkso9
         0bAAEK/rEgjp9qbUES1IIThnCrbQuK6owIdEaLNuEGfhrKKpykPlH48xjhBVXR1bdQle
         7XLA==
X-Gm-Message-State: AC+VfDyNFOn+br179BC+qZ6x0iD/oBvIcYgSBIPRnS2MI0qNddseDFUo
	FJTZtFvodAx/VY5YD5OedFEaemUB8R5QIqKo4Q33iXkqYdmRpa7zpDyr9HaDebBgE2MnRUOHYPD
	BChVw6jf1k75VamvDnlYPbrdRzIs1
X-Received: by 2002:a05:6a20:3d8e:b0:106:76e8:940a with SMTP id s14-20020a056a203d8e00b0010676e8940amr214825pzi.61.1684128003325;
        Sun, 14 May 2023 22:20:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4tsyOVU9Yna6hVT6saFlpuvo/O1cuVDo1ic/URPDT7iGugv8JAcT9NZ1OqH6OoZoVEyeZN2Q==
X-Received: by 2002:a05:6a20:3d8e:b0:106:76e8:940a with SMTP id s14-20020a056a203d8e00b0010676e8940amr214805pzi.61.1684128003011;
        Sun, 14 May 2023 22:20:03 -0700 (PDT)
Message-ID: <eb69906c-818b-a1ee-3317-262e159785e0@redhat.com>
Date: Mon, 15 May 2023 13:19:57 +0800
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
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <20230511085519-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230511085519-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ


在 2023/5/11 21:04, Michael S. Tsirkin 写道:
> On Thu, May 11, 2023 at 03:06:48PM +0800, Jason Wang wrote:
>>> With that I don't see legacy 3 commands anyway conflict with [1].
>> It doesn't, but it's not elegant since:
>>
>> 1) Modern transport, admin virtqueue with well defined transport commands
>> 2) Legacy transport, works moe like a PCI transport on top of the
>> admin virtqueue
>>
>> Transport virtqueue tend to be transport independent, but 2) tie it
>> somehow to the PCI.
> This "somehow" matters though. The connection is really just the
> common config layout.
>
>> That's why I suggest to
>>
>> 1) introduce legacy transport commands
>>
>> or
>>
>> 2) tweak your proposal to become a PCI over admin virtqueue
> So you are saying it's really not generally "legacy over
> admin queue" it is more like "legacy pci over admin queue"?


Yes.


> Good point.
>
> And I feel it's a good point that this chooses legacy pci but it could
> really be mmio or ccw or the upcoming vq transport just as well.  I suspect
> mmio or ccw won't work well for a physical pci card though.


Right, but as discussed, a possible user is the SIOV transitional device 
via transport virtqueues.


> transport vq might, but I am worried we'll have to spend extra
> work clarifying it's a legacy interface. For example we will
> have to explain that only 32 bits of features must be used.
> Focusing more effort on transport vq is attractive though ...
> It is worth examining this option in more depth.
> Did you?


My understanding is, for any case, we need such clarifications. What 
Parav proposed here is not the access to the actual registers but stick 
to the semantic of those registers. I think we must say high 32bits of 
the features must be assumed to be 0.


> Want to share how is transport vq closer than
> legacy pci to what we might want?


I'm not sure I get the question, but in another thread I show 10+ 
commands to access the legacy facilities which is really very close to 
the transport virtqueue.

Thanks


>
>
>>> Some commands functionality is common between [1] and this proposal.
>>> But that's how the legacy is. It is confined to legacy emulation.
>>> So [1] can be done as follow_on to AQ and these series.
>>>
>>> A small note about [2].
>>> virtio_transportq_ctrl_dev_attribute should be detached from CREATE call and split to two commands.
>>> So that VF and SF/SIOV can both utilize it.
>>> SF/SIOV_R1 can use the creation and config part.
>>> VFs will use only the device features + config space.
>> Good point. This could be fixed.
>>
>> Thanks
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

