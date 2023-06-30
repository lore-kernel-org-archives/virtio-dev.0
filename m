Return-Path: <virtio-dev-return-13193-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C55EB64D7
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 14:57:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D0DCA2B139
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 14:57:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5F3C9866F8
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 14:57:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9F9F69866EC; Fri, 30 Jun 2023 14:57:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8DA7C9866ED
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Jun 2023 14:57:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2H4wlCkjOUWt4y9Htzu7OA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688137026; x=1690729026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYZdjL6bktzV6J7h5TpafIHB5blnmESmgEG2ov5eULE=;
        b=G0Ok1uggd9gboxHi5QlMGseIExwM2Et8rNl2JXU4jxiRqcmJoNVVBa6HCuUHZMZLJB
         7tB4KVQBVwMN7e2ihHyBuDpkyQ7Q0flRu+vBgx/VB15y6xCMMkJR5qW2lQtIB1CGMJ3t
         e8vpdhyUHlUohmDUeXIS4aFqh1f1YEZE9iS2L3H3dcGoA16RRrRgU7hGR15Gb3JYEvLS
         G5Eli0my/W4AsZERrCPBwX+KqcTM5xaXUPH3zxrgYvyuKXQIO7JRiePrZA149nXnfpyD
         0w/bA5+sO8EUjk2h2W9ydu2srUCdXUW2EmA3BCv/9sO6aSNoOSjnmJ1hAhbcKnvbTQzg
         /COw==
X-Gm-Message-State: ABy/qLZuTaNbBlm+oXpyF7Vpds0wBGSdekBRh9II+zBmTn2+bi2Shndf
	DAOp/3q9/wQcTxd44DrCjzxvcwn91Y7vEdG9zR7e6oJUfkpfbPs6BYWd/mGoiXhWrolsIb0zodF
	pApu3FX4W48jZ8Yvw9hIRbZ0sI+PXulQt+gPt
X-Received: by 2002:adf:f74c:0:b0:309:3af4:8c8c with SMTP id z12-20020adff74c000000b003093af48c8cmr2341822wrp.54.1688137026204;
        Fri, 30 Jun 2023 07:57:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEMGiAQU1WtG1A0VKLRgKtG2NnCiTVxPwln/aWhUWP+h+KoPSHTd8Ru3gq/UYszyxZWNRzMsA==
X-Received: by 2002:adf:f74c:0:b0:309:3af4:8c8c with SMTP id z12-20020adff74c000000b003093af48c8cmr2341812wrp.54.1688137025935;
        Fri, 30 Jun 2023 07:57:05 -0700 (PDT)
Date: Fri, 30 Jun 2023 10:57:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	quic_ztu@quicinc.com
Message-ID: <20230630105606-mutt-send-email-mst@kernel.org>
References: <20230417140353.870-1-quic_haixcui@quicinc.com>
 <20230417140353.870-2-quic_haixcui@quicinc.com>
MIME-Version: 1.0
In-Reply-To: <20230417140353.870-2-quic_haixcui@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev][PATCH 1/2] virtio-spi: define the DEVICE ID for
 virtio SPI master

On Mon, Apr 17, 2023 at 10:03:52PM +0800, Haixu Cui wrote:
> Define the DEVICE ID of virtio SPI master device as 45.

It does not looks like patch 2 will make it in time for 1.3
but should we vote on reserving device id maybe?
If yes pls create a github issue and request vote on list.

> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index cff548a..29f2859 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -682,6 +682,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  44         &   ISM device \\
>  \hline
> +45         &   SPI master \\
> +\hline
>  \end{tabular}
>  
>  Some of the devices above are unspecified by this document,
> -- 
> 2.17.1
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

