Return-Path: <virtio-dev-return-12706-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE9FC77B7A
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 03:38:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C7E7319092D
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 03:38:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3C039865BA
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 03:38:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AFFD0983DA0; Tue, 16 May 2023 03:38:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 997B3986511
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 03:38:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: VycPGPMqMkWxPyOhonUPnA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684208278; x=1686800278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+4wzhCvNOqf7DwUHzmUni+2X5utT3WSg8ch+30+7ng=;
        b=AznzSiYwmFypNvx4S35oF8Qb5BEC0x3QbCViKlRKmW3UvBFbN0FEMglE4y0daYX9FV
         FjaAi4Zfzao2DqmsoaTVQOwShAROT4iURNOkmYocNu1cmYB0ohI3TZ8UDkhwVppI5uEo
         yHXY6IaZmnkrBSc3gkvUwsUtXpVQys6LztOmLX24MnuZHbMLkUQlB5ANf3EQocLLSwFw
         orsr9isAE+WLqWm1Ugb63cu9cjH275KpeRnknPAq9h/W3g+7ofLTCuIglI6HmRTDm5hP
         uvWDDlrUKahkGKHNMXSOPQ7XpOqRvUguHvptUNuxuwCaVj/x1ZLyEqnnj6oqP5txhAaV
         NRGA==
X-Gm-Message-State: AC+VfDxDFqszh22uD6Qk9JKdy1T4FTbGtI8kaLrJTpHFi0fDEOUP/j+O
	snAy/30d0c+Je1i59ygTEy3KHUUp6rlh8ChCUSYKzXPi/7pd99x6SM8Mm4iiXnDHIMjx+eP/knE
	se8jSbcHXK+bsXLlrAWEjvWurWU1O
X-Received: by 2002:a17:903:25cf:b0:1ae:6a6:9ee4 with SMTP id jc15-20020a17090325cf00b001ae06a69ee4mr8142327plb.29.1684208277746;
        Mon, 15 May 2023 20:37:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4JeAv7BkkSsenZea7QZroAchdZoKpySAk3Rjyg6er/jsoENLqCBgcwj7sDqSidx13wBPa8Pw==
X-Received: by 2002:a17:903:25cf:b0:1ae:6a6:9ee4 with SMTP id jc15-20020a17090325cf00b001ae06a69ee4mr8142317plb.29.1684208277466;
        Mon, 15 May 2023 20:37:57 -0700 (PDT)
Message-ID: <78ade48a-6f5d-8a2d-1524-44340f0154ce@redhat.com>
Date: Tue, 16 May 2023 11:37:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "david.edmondson@oracle.com" <david.edmondson@oracle.com>,
 "sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas
 <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Shahaf Shuler <shahafs@nvidia.com>
References: <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com>
 <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515133719-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810DE3ECAE95689F80C596DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515135513-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481923CB4F23968C39F14D8DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515140052-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230515140052-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ


在 2023/5/16 02:01, Michael S. Tsirkin 写道:
> On Mon, May 15, 2023 at 06:00:02PM +0000, Parav Pandit wrote:
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Monday, May 15, 2023 1:56 PM
>>>
>>> On Mon, May 15, 2023 at 05:51:05PM +0000, Parav Pandit wrote:
>>>>> From: Michael S. Tsirkin <mst@redhat.com>
>>>>> Sent: Monday, May 15, 2023 1:45 PM
>>>>>
>>>>> On Mon, May 15, 2023 at 03:49:44PM +0000, Parav Pandit wrote:
>>>>>> All legacy interface via AQ.
>>>>>> All modern interface access via PCI or its own transport between
>>>>>> driver and
>>>>> device.
>>>>>
>>>>> I am wondering however about the hypervisor notifications.
>>>>> Generally these are the most problematic aspect here I feel.  For
>>>>> example, how does it interact with VIRTIO_F_NOTIF_CONFIG_DATA?  And
>>>>> generally, having both guest and host be allowed to access device's BAR
>>> seems problematic.
>>>>> Can we reserve a PF BAR region for these things or is that too expensive?
>>>> VIRTIO_F_NOTIF_CONFIG_DATA is not present for the legacy.
>>> it is not but it just might be required, or it won't be there.
>>>
>> How can it be required if it not part of it?
>> I likely didn't follow your question/comment, can you please explain.
> VIRTIO_F_NOTIF_CONFIG_DATA is there presumably for a reason.
>
>>>> For modern device, guest driver will access the device own BAR directly with
>>> its own config_data anyway.
>>>> Should we reserve a region in the PF BAR for SF/SIOV device?, should device
>>> report which BAR/area to use for the given SF/SIOV device?
>>>> May be yes, those are different discussions with tradeoff to consider during
>>> SIOV discussions. It is not related to VFs.
>>>
>>> For SIOV it's a given. But we can do this for SRIOV: reserve a PF region per VF.
>> Each VF has its own BAR area for driver notifications.
> But it is passed through to guest presumably.


Probably not in the case of VIRTIO_F_NOTIF_CONFIG_DATA. Did you see any 
problem if we do mediation here except for some performance penalty?

Thanks


>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

