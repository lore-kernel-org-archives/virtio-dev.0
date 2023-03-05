Return-Path: <virtio-dev-return-11428-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451F3C6FA8E
	for <virtio-dev@archiver.kernel.org>; Sun,  5 Mar 2023 09:39:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A9BBE71C8F
	for <virtio-dev@archiver.kernel.org>; Sun,  5 Mar 2023 09:39:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 95859986436
	for <virtio-dev@archiver.kernel.org>; Sun,  5 Mar 2023 09:39:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 877499863D3; Sun,  5 Mar 2023 09:39:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 74F3A986448
	for <virtio-dev@lists.oasis-open.org>; Sun,  5 Mar 2023 09:39:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Lge_bNEGOrOxaym2jf0wqA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678009144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N048sCiPa8dCvUtJZqJRm0pckfHsh/MfhrWWCO1+AcQ=;
        b=3BwJqVBFKELtZXHoIJ8t/7r8IwuVDCEVM1Biob9sOh8LiKJJKtG/K0H7fcN87yYS+Z
         6+Yl8j7YUNdVYgjJHktidcprvcoFkDTYs0f6rbip/jZMwlBr03FU99SFhIo6QUTFJyvC
         KnR3tMFeyijrLMeSxndYph6/2t/tCyfZm64cs5iti9bDurwwpkXS68Ex+0XXdQ7pFLf1
         5rBLt2qi3NXF76EU7kw2KALd6Wkx4rweH0ybjAcUOCJNzs94JR7KBPVTuwD0JW/qbTef
         Cww1XsvL6/CQuiaNltcIFsc8TB8m/XIDyxd8vs6cvUhcWVMfFa0tzyxkS244ihLjUek4
         hi/Q==
X-Gm-Message-State: AO0yUKUpQq6YS5mdUus1Tp+S6g1GZqUM8a7byzwgfhmRLafkLQi29nWw
	NNHDFd/K0PwEAE0pkWTM32VIEQOYnD3oSqfP8T9M1sg8GR1fqKUTboMx9Q54om3A7GAwkNsX2As
	I3XfjsNvnnuPiRD/4z5zPBTzy8f6s
X-Received: by 2002:a5d:52c4:0:b0:2c7:390e:163c with SMTP id r4-20020a5d52c4000000b002c7390e163cmr5188936wrv.47.1678009144502;
        Sun, 05 Mar 2023 01:39:04 -0800 (PST)
X-Google-Smtp-Source: AK7set9sZcDf0HY83s9267Uclwt4GG0Hq4RlXJVeKy6Gh2F4hEyS8V/MV/CgT++2Vb4DDivTr3TLiA==
X-Received: by 2002:a5d:52c4:0:b0:2c7:390e:163c with SMTP id r4-20020a5d52c4000000b002c7390e163cmr5188927wrv.47.1678009144251;
        Sun, 05 Mar 2023 01:39:04 -0800 (PST)
Date: Sun, 5 Mar 2023 04:38:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230305043419-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
 <20230303132840.GC2866370@fedora>
 <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora>
MIME-Version: 1.0
In-Reply-To: <20230303202133.GA2901137@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio] Re: [PATCH v10 04/10] admin: introduce virtio admin
 virtqueues

On Fri, Mar 03, 2023 at 03:21:33PM -0500, Stefan Hajnoczi wrote:
> What happens if a command takes 1 second to complete, is the device
> allowed to process the next command from the virtqueue during this time,
> possibly completing it before the first command?
> 
> This requires additional clarification in the spec because "they are
> processed by the device in the order in which they are queued" does not
> explain whether commands block the virtqueue (in order completion) or
> not (out of order completion).

Oh I begin to see. Hmm how does e.g. virtio scsi handle this?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

