Return-Path: <virtio-dev-return-13761-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD81EDE9A5
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:09:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0E5E32AEDD
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:09:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF86398664A
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:09:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C250798402B; Thu, 14 Sep 2023 11:09:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B091C98663D
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Sep 2023 11:09:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: fpg-uHsgOTeo4eQX4bgElQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694689746; x=1695294546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKwlPnxTwN46qRBNG5QBmwFoFAi3nHA9falJh7CT7vo=;
        b=s99JqFnbwTk8ni6XQVdjEtBH/ACFO6XvdmoWFR+H2MudfsxxshH516ua37RreR4xrH
         ka+SI9/2dDH0giLZz6BBvM/IO9m6vL4zMLmoqb1M23EG5axJr5RBBsziNdQwcNjvF5WE
         GrtC2iXkitorL9pszuy0fKX2/ciRLsUtPtXyN34LaQ1/3q7hAwyidxkzfMfS9fCEf4od
         wFKe6t03zhzIBUr7SsAnJy5L8med03m8A4PSjTLzMjNSBHQv4ZAtUKsYDLbbYN8ciO2W
         ewMn6Gb7tTcs9QsbnlRYfn7rq1mUgz74qwsX0RYMdJUZqwAKPaSL8EWiAXtMZ1wNhFWQ
         ur3A==
X-Gm-Message-State: AOJu0YwDSWsnNO6LdZG4ReFz52NHNSVQgw9rEKLL1wvxs9nPECmLgUZv
	HTuXkFE32KUEleXo4HV/Wd37UEIlELLjInQ86FqpZixWDz6jtXniBKR9Kd5b0VERd1324DzBvf/
	O56+jjQm4qzKoqJVCSiQ8OvJPwn9G
X-Received: by 2002:a05:6512:3f5:b0:4fb:741f:75bf with SMTP id n21-20020a05651203f500b004fb741f75bfmr3852762lfq.16.1694689746302;
        Thu, 14 Sep 2023 04:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf7SFya7g2VBoSuRNVXj7wPMKINRzbToosU76MVscHp32jqRWBu87OcelRagR13Wl2X84/sw==
X-Received: by 2002:a05:6512:3f5:b0:4fb:741f:75bf with SMTP id n21-20020a05651203f500b004fb741f75bfmr3852740lfq.16.1694689745900;
        Thu, 14 Sep 2023 04:09:05 -0700 (PDT)
Date: Thu, 14 Sep 2023 07:09:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
	stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230914070739-mutt-send-email-mst@kernel.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-5-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20230906081637.32185-5-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 4/5] virtqueue: ignore resetting vqs when SUSPEND

On Wed, Sep 06, 2023 at 04:16:36PM +0800, Zhu Lingshan wrote:
> When SUSPEND is set, the device should stabilize the device
> states and virtqueue states, therefore the device should
> ignore resetting vqs when SUSPEND is set in device status.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>

And do what? If you really feel it's important we can prohibit
driver from touching state. But generally this seems
un-orthogonal.


> ---
>  content.tex | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 9d727ce..cd2b426 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -443,6 +443,9 @@ \subsubsection{Virtqueue Reset}\label{sec:Basic Facilities of a Virtio Device /
>  The device MUST reset any state of a virtqueue to the default state,
>  including the available state and the used state.
>  
> +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set in \field{device status},
> +the device SHOULD ignore resetting any virtqueues.
> +
>  \drivernormative{\paragraph}{Virtqueue Reset}{Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset / Virtqueue Reset}
>  
>  After the driver tells the device to reset a queue, the driver MUST verify that
> -- 
> 2.35.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

