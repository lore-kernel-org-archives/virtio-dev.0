Return-Path: <virtio-dev-return-12745-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3317EC7EE2A
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 05:44:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3FE46C5AE8
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 05:44:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 243D69862FD
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 05:44:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0F9EC983DFC; Wed, 17 May 2023 05:44:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB5C998632A
	for <virtio-dev@lists.oasis-open.org>; Wed, 17 May 2023 05:44:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: zNeQPl77N7OqLoAAjTCspA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684302276; x=1686894276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyLFJDEmnS8gP1P2TSEeeWkOW8BcxQb6Efe2a+tsk+I=;
        b=jYyoSQCAcwI6LOZ4TI2RmygdG1OVKDPjoQvMC0DHtCDoTgcLRgHe0YeDeldU2jJFoo
         kyV5Btb0ezyzgy9StfzPJKn1I7FUQF8S1Jdp/uKzDCRTQzxGnGv2edzTc3eDwKxBBc7i
         PBI0w3XEwxRxLweTZSRcJouYeT8nkfVnx6EdwaZdo9ucmRg9TsIuy3e5TGZrP6ICv46J
         kyVuAHpfDN0WyJ7xoo9KcZIvqN/EINeTLISfkPfzFhEoxQLpItZWPQftFMDPOwBrmD0V
         SR9bstbsk1+SaxGbs83RUK3AVa+V3UsyqOSy8TV0x2SoK4AqHXBT2aLcjLAgfpnWsPhS
         /Efg==
X-Gm-Message-State: AC+VfDybbb8blemGKK356i/Zek7ylelpqLRhBLyTvkst2dyItoZPa0PQ
	/yr3nJj7n92YlXmHkW/yJGqcDTHSmF7fVVyp2NpLKqDp6K0mtNOqq5uNtCw61f+6L5A6Xkgr2i8
	YFkBXTDRGcwZf/4YbSiWOJtR3nlmQ
X-Received: by 2002:a05:600c:35c5:b0:3f4:1848:4dff with SMTP id r5-20020a05600c35c500b003f418484dffmr718469wmq.7.1684302276478;
        Tue, 16 May 2023 22:44:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Fx9bgCXxc/ehCPq22F1lMpkeA/FlyAiWtNn0YuQDTtrgUJfQCN7zG9MPky3z9G6/WKDP5GQ==
X-Received: by 2002:a05:600c:35c5:b0:3f4:1848:4dff with SMTP id r5-20020a05600c35c500b003f418484dffmr718450wmq.7.1684302276187;
        Tue, 16 May 2023 22:44:36 -0700 (PDT)
Date: Wed, 17 May 2023 01:44:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
	yishaih@nvidia.com, maorg@nvidia.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230517013839-mutt-send-email-mst@kernel.org>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230506000135.628899-2-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230506000135.628899-2-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v2 1/2] transport-pci: Introduce legacy registers access
 commands

On Sat, May 06, 2023 at 03:01:34AM +0300, Parav Pandit wrote:
> +\begin{lstlisting}
> +struct virtio_admin_cmd_lreg_wr_data {
> +	u8 offset; /* Starting byte offset of the register(s) to write */
> +	u8 register[];
> +};
> +\end{lstlisting}

So to summarize, I think the main comment here was to have separate
commands for access to common versus device config. Just today I thought
some more and came up with another reason why this is a good idea: if we
ever want legacy MMIO emulation, we can reuse the device config command.

Jason also feels the common config command can be shared
with vq transport effort. We can discuss this, for sure,
I guess its putting code in hardware versus in hypervisor,
but if there are hardware vendors who strictly want
this code in hardware I don't have a big problem with this
even if I don't exactly get why.

With this idea all hypervisor has to do is subtract the offset from
device config access, sounds like a small price to pay.  Does this sound
like a reasonable compromize to you?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

