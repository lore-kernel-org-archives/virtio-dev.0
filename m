Return-Path: <virtio-dev-return-12489-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838AFC77B73
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 07:38:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9BE8442B6C
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 07:38:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 787529864A3
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 07:38:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5726B986466; Tue,  2 May 2023 07:38:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 42FFA986485
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 May 2023 07:38:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ywEbVigXMFGoOOPuXKocZg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683013076; x=1685605076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFH+IbsBqZcXZOYadcvfgZk3qMV2WgOsOyqVfj7ZOSE=;
        b=g0vkAN41wnKi/DSdTaTK0tzPjyHd4ADEn6NT4vA2Ac1wZiGmseddwVIr2z1vorTmit
         XkGnZ1pz6ak3hRNqQl5XZas3YWcwQ3LQ++EsdR6tER4cWugohdYYWWGt7Prktv5eb87s
         EblApIexEc8CSXLdN8pvaMA7zz192S5bNhpoDAzBIWdKzb1Ra3/mj0dE/ASfSJWQ6EGo
         arMP7Mt8hvGjpfXOFfF9fsa3rLm4d/7wdxBH3beHG5rYD8JAEveRu5V/xZR0xh1uUKvb
         IPlSTPgxJpLGkcy2rPcml29ZRy5UCzqojYZ+2pXCpDo7DldJ580v2fquGoWguUx3vbZz
         CZZg==
X-Gm-Message-State: AC+VfDypjjgEs3pMhrnBVy9+0i5b/GIUkfHjxbW0BLjNEoDy7M3Non60
	BZn2l/Ff+4B3RDW+fI/0grD4UM4Onwe+xUcsVHbOt2ZD043mAflAp0A8pjtU1RTQ5swMhT7873v
	c+4iifXxArUo6JBEZ6n2DxEjSw9nv
X-Received: by 2002:a5d:5581:0:b0:306:2927:b581 with SMTP id i1-20020a5d5581000000b003062927b581mr5209713wrv.46.1683013076563;
        Tue, 02 May 2023 00:37:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6xMvEDveOrTmCvLNwI+c/bc2hs4y2LJg1J+VJHtwDiwu7jMJGRmAbIJmM8Y4jyz1QY8NjCIQ==
X-Received: by 2002:a5d:5581:0:b0:306:2927:b581 with SMTP id i1-20020a5d5581000000b003062927b581mr5209692wrv.46.1683013076177;
        Tue, 02 May 2023 00:37:56 -0700 (PDT)
Date: Tue, 2 May 2023 03:37:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230502033510-mutt-send-email-mst@kernel.org>
References: <20230501224430.485139-1-parav@nvidia.com>
 <20230501224430.485139-3-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230501224430.485139-3-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 2/2] admin: Make optional command data type to u8

On Tue, May 02, 2023 at 01:44:30AM +0300, Parav Pandit wrote:
> Command data content is specific to command opcode.
> This is similar to command result field
> command_specific_result.
> 
> Hence, make it u8.
> 
> This patch is on top of [1].
> 
> [1] https://lore.kernel.org/virtio-comment/cover.1682354275.git.mst@redhat.com/T/#t
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Thanks for the patch. It was like this originally but readers were
confused.  The point of marking it le64 is to make it clear it's size is
a multiple of 8 bytes, thus 64 bits. And format of fields inside it is
generally LE.

> ---
>  admin.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/admin.tex b/admin.tex
> index 037e2e6..648253c 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -85,7 +85,7 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>          /* unused, reserved for future extensions */
>          u8 reserved1[12];
>          le64 group_member_id;
> -        le64 command_specific_data[];
> +        u8 command_specific_data[];
>  
>          /* Device-writable part */
>          le16 status;
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

