Return-Path: <virtio-dev-return-12523-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89777C77B75
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 19:21:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B35A4142D46
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 19:21:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ADB4A9866B5
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 19:21:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A1FBA986594; Wed,  3 May 2023 19:21:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 90BEE9865A1
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 May 2023 19:21:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: gp9SEmBJOCS080LsifUoRw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683141707; x=1685733707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8MbwsKW+Wd4vLqhW2fMXV4984+gwPp+Hk825RieqPU=;
        b=V44po/iXMoGqZgict+rFCKKn/aQF1a6nISj0Plil6qOx8bf3XoS9VpN+0uWCaUkrrB
         XpUTthNsLOoxPMGcZeBDYJO/zgx1qRMvmL7lwCddDdums/TR0LpxNLQR2J/e9zUy5I4/
         Cwrl8Vy2vu0TW7ES4qVzU0SM9zrVx09hAFdrtwOUhrryXUPvbC8g5ha2Je17RYOpMddG
         VYIykUctDbqTnkhxnq2jq5lBG8iBdC2sWdZdJXJUx5Ra4u8bZXs0/X3WovyNeKMQ/ziY
         Q0zYkU65Qmb2tJFaWFeWQXM7JxMfCR3Su/qFc/UtCz+zUCN2XijvdkNbCmVB+M3zsH01
         TSGQ==
X-Gm-Message-State: AC+VfDzw6WbaBkHpFGQQLTBzD/HujV+Ly9h6aAgceBdgC0v526NuA7pX
	GqSl4e5BNdTkNFasEV63EUUM50wjaZHjsaw8pVlMwx8dFDzQ1ZlLwwBLL8v7qdqJbUQMIi+U2n3
	EhnWhEkgnglMDg5eQvBi15wVScA4T
X-Received: by 2002:a5d:668e:0:b0:2d2:f3e3:115d with SMTP id l14-20020a5d668e000000b002d2f3e3115dmr590297wru.59.1683141707376;
        Wed, 03 May 2023 12:21:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6fenEIDmmCVG05nfObcOOBbyUdX/9dLVyxZvfUGbZvEmmKCnebgWVpsTAp3ZCqORvbfqbRdg==
X-Received: by 2002:a5d:668e:0:b0:2d2:f3e3:115d with SMTP id l14-20020a5d668e000000b002d2f3e3115dmr590290wru.59.1683141707056;
        Wed, 03 May 2023 12:21:47 -0700 (PDT)
Date: Wed, 3 May 2023 15:21:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230503151908-mutt-send-email-mst@kernel.org>
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503032659.530330-2-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230503032659.530330-2-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v1 1/2] transport-pci: Introduce legacy registers access
 commands

On Wed, May 03, 2023 at 06:26:58AM +0300, Parav Pandit wrote:
> +\begin{lstlisting}
> +struct virtio_admin_cmd_lreg_wr_data {
> +	u8 offset; /* Starting byte offset of the register(s) to write */
> +	u8 size; /* Number of bytes to write into the register. */
> +	u8 register[];
> +};

BTW if we don't have padding we could reuse buffer size and won't need
size here.  Do we want to tweak admin command structure generally to use
u8 and not le64 for command data then? WDYT?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

