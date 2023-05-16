Return-Path: <virtio-dev-return-12709-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B97C77B7A
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 03:54:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E7D12673A4
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 03:54:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB6189865B0
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 03:54:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CF2FD983DA0; Tue, 16 May 2023 03:54:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA76B986510
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 03:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: NyTLPEnZMtmj4uJyOcILMQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684209285; x=1686801285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEKfgDzUJFVvDFeTIT8FuQHMolJk5MWsYh5MD4zEzlE=;
        b=Krv+ZYxUnLnG/BvP8O9NvOjWJfRymYEoQPnu6Nr7ac/8nkKTv7X7m/oqthDDLGpvY+
         UUzxf7I5+TRudMoAW7wlIxSbByFI3i5s6Uw1nvEhLJh8JZRCpgafjFBH6mgzhufzpZbv
         xKYppo7GtENdGLPpxR8e/3JP5qU5OvAXmap4fVSKlVB9nKAQUsyM6WgsK+QHa0Q6hL6m
         ria3iXiRf5Qykd0GCgnWQZr07ydN0R5RVpAtIUvrm42Vfa5ViX/ThAkiB+i5T38XMmcE
         z8iFw/PhCKDaq1cyT3S9b1aP46A+0OuLg+nlUr/2e1bx98Fw83iH9G5+0BW2Cbwv6NhY
         rsoA==
X-Gm-Message-State: AC+VfDwYHoAym5dbwnGxT6O6EEdGg/qnSMdZv3UqsFagHKmFa/N2LlEx
	m2uPIsA71l+HqeWon5EZVV9XXhDcoUbqhn+eBjKWcWFVSFpP3s0Jm30rfMXLXmA6s0RFEEAGgA6
	J+JyMqQ1ofAHK69E9cvIyKkEEJXiQ
X-Received: by 2002:a17:90a:ee88:b0:247:13f5:47de with SMTP id i8-20020a17090aee8800b0024713f547demr34828412pjz.44.1684209285655;
        Mon, 15 May 2023 20:54:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4xLpfIy921KY5nFSp3NY04YscyWwrVcTqD4W98fd0nbH0tbiZsVUMDSFQXyZThMKwJNZpUsw==
X-Received: by 2002:a17:90a:ee88:b0:247:13f5:47de with SMTP id i8-20020a17090aee8800b0024713f547demr34828398pjz.44.1684209285338;
        Mon, 15 May 2023 20:54:45 -0700 (PDT)
Message-ID: <83603339-e3fa-fe56-d447-813e73eb1961@redhat.com>
Date: Tue, 16 May 2023 11:54:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
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
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <PH0PR12MB5481BCA4D8F6546B3300DD29DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <PH0PR12MB5481BCA4D8F6546B3300DD29DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ


在 2023/5/11 21:15, Parav Pandit 写道:
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Thursday, May 11, 2023 3:05 AM
>> If we decide to use the admin vq, is there any good reason to tie it to PCI if we
>> don't want to tunneling PCI over adminq?
> To truly tunnel PCI over adminq, please tunnel _all_ pci things over AQ, not just below 1 to 11.


Just to clarify, below 1 to 11 is not tunnel PCI over adminq, it's the 
idea of transport virtqueue which is not specific to PCI.

If we want to tunnel PCI over adminq, it needs be accessed via your BAR 
access commands.


> Doorbells, capabilities and more. Then it is qualifying as a transport.
> Otherwise, it is not a "virtio pci transport over aq".


Yes, it's basically just have some extension on your proposal, adding a 
config space access method that should be fine.


>
> I neither see why one would tunnel whole PCI over some queue, which was not your intention either from the patches I see.
> VQ over fabrics is much cleaner design to transport VQ over non-PCI.


That's a different topic, and we don't need to think of the legacy 
support there.


> People have tried to tunnel pci over some other transports and it only fine for non-production toys.


I've replied this in another thread.


>
>> Why not simply invent individual commands to access legacy facilities like
>> commands to access like what transport virtqueue did for modern
>> device?:
>>
> I don’t see how this is being any different than register-offset interface.
> It bisects more things at hypervisor level that makes things hard to add #12th entry.
>
>> 1) device features
>> 2) driver features
>> 3) queue address
>> 4) queue size
>> 5) queue select
>> 6) queue notify
>> 7) device status
>> 8) ISR status
>> 9) config msix
>> 10) queue msix
>> 11) device configuration space
>>
>> It focuses on the facilities instead of transport specific details like registers (we
>> don't even need legacy registers in this case), I gives more deterministic
>> behavior so we don't need to care about the cross registers read/write.
>>
> 1.x has these registers at raw level and that seems fine.


Note that 1.x has more, the above is dumped from the section of "Legacy 
Interfaces: A Note on PCI Device Layout".

Thanks


> Anything new will come on the cfgq and hence no bisection or registers needed.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

