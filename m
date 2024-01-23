Return-Path: <virtio-dev-return-14263-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E73C47DDB
	for <virtio-dev@archiver.kernel.org>; Tue, 23 Jan 2024 06:58:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 311992AFFE
	for <virtio-dev@archiver.kernel.org>; Tue, 23 Jan 2024 06:58:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0CC129866D8
	for <virtio-dev@archiver.kernel.org>; Tue, 23 Jan 2024 06:58:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E69029866BD; Tue, 23 Jan 2024 06:58:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D4E239866BA
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Jan 2024 06:58:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: sLUka-4JNJKcapk9VB8EXw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705993109; x=1706597909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjdzgPflmkPTdjqjY3PVFxZWw28Po5K5KPAgV8DOYik=;
        b=O6r7Uzk5XttO/G+dIgrcqiGufaNfaR3dgemfurdLJHF7CPl0y0zJlRWOifA6uogN0q
         4slS6b1jDxC7m2eR0eSXJvByuczZhH2fNuUhAUvdsZbDZqVUFjuiSWWBrC+xOOltbSeL
         wJRXWPvPGc/ZAd1KHKnMDotIXulyJB2sB9gPe61/zY+AEssW2gwY5E9K090dQl8oEhnZ
         e3JKKiOWdoUufmy4VYbt8VeVH48xek5WlUQxGIEAdtI3cY8c/Xm20FxS7oQQS/M0ytlE
         Mh4iJUBhabJl+raxabicorITLXLXx4O89Pb1U1AJCt9lgPQ4CvYBpLitdUlfv5ywSZeC
         yBow==
X-Gm-Message-State: AOJu0YwdmLpfZfq0pU9QQjRbBC7BJs2azYLMzeBA3a6IvjyAdGeg25AN
	li1RQmx/OSwa4/dvlRa8pWNB3XhApkvYGPoFVU70fkdv4iTUY1o4hYbJFSbdL9Wd38DNqpqsgsL
	+Q3HxFsK6n5mznoCeQWXFKjmUFeuMsrYaKYRITmb/pWH46WgnrNtqpyXiWHvCFtZjEw==
X-Received: by 2002:a05:600c:4214:b0:40d:87eb:56a1 with SMTP id x20-20020a05600c421400b0040d87eb56a1mr224289wmh.169.1705993109202;
        Mon, 22 Jan 2024 22:58:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIuRbT5M1NK+6nhfoOT02m11jM5U88pRll8Ahl7A5vGQIYUXotGori9MxOH3eizZ+knbflHQ==
X-Received: by 2002:a05:600c:4214:b0:40d:87eb:56a1 with SMTP id x20-20020a05600c421400b0040d87eb56a1mr224284wmh.169.1705993108872;
        Mon, 22 Jan 2024 22:58:28 -0800 (PST)
Date: Tue, 23 Jan 2024 01:58:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shujun Xue <shujunxue@google.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	Slava Malyugin <slavamn@google.com>
Message-ID: <20240123015739-mutt-send-email-mst@kernel.org>
References: <20240122231157.651024-1-shujunxue@google.com>
MIME-Version: 1.0
In-Reply-To: <20240122231157.651024-1-shujunxue@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH] Define the DEVICE ID of Virtio Cpu balloon device as 47

On Mon, Jan 22, 2024 at 11:11:57PM +0000, Shujun Xue wrote:
> The virtio CPU balloon device is a primitive device for managing guest
> CPU capacity: the device asks for certain CPU cores to be onlined,
> offlined of throttled, and the driver performs the requested operation.
> This allows the guest to adapt to changes in allowance of underlying CPU
> capacity.
> 
> Signed-off-by: Shujun Xue <shujunxue@google.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 0a62dce..6149612 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  45         &   SPI master \\
>  \hline
> +47         &   Cpu balloon device \\
> +\hline
>  \end{tabular}

Did you change anything in this patch? CPU should be upper-case.


>  Some of the devices above are unspecified by this document,
> -- 
> 2.43.0.429.g432eaa2c6b-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

