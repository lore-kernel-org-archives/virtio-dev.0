Return-Path: <virtio-dev-return-12711-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D66C7EE26
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 04:13:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A531CF936B
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 04:13:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87935986510
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 04:13:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6EF42983DA0; Tue, 16 May 2023 04:13:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5CC0D986511
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 04:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bXjeD0XHNJWAR9dD9ycuBw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684210386; x=1686802386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwlPpIHPiMhlaGPr2kjj+GWduEqbPSymhbswgtEXn9w=;
        b=X54nfGwiYTnpeUBrP5AK51FBeFwkpPTQTSS29cDGjlXxMUdg1vV1kgD2IRFnLd6I1h
         ufZJ/9cOWHY4jsc18Rq0tibENLwTLPSmH0kFjQWU+dvFNgR7n4n13Q8NHbfGampx+S4y
         uAJ7raLJpS+Dcl+/9ZENVyGMo4g+7+YnEXFf0gnhpi693+bhMbJjnTMbXajE4cRnPekw
         IkCQwz3iGwD63Yh5jBqzmLr96AFb4xVemooOzDjKcwj3n40hFTUy7ob/BJ4Oc7TVdQr0
         6+ovorcGFe9HT5pX1794iO9RbXAtWBXtqjmosJSPvKnCe6ERQAcNTUwMzeI2pKPVjXXh
         oVcw==
X-Gm-Message-State: AC+VfDxshjwQaYMtUrwmLNjIYzk8cGmq9tFq956x5J26uJLgrI5o68ec
	SUO6JoVmsmQw4WaMx9vgjOxtpO+NJ5vE5IEsW49k2BvWgQ5Vv9BWBrUyNgMp2gJfH62RZmAGWSt
	OqyjtDJ4ofK0HlrYMoUfx0drgRYeL0kKWvd4jBJ2Sg1m/
X-Received: by 2002:ac2:4208:0:b0:4f0:206a:9fae with SMTP id y8-20020ac24208000000b004f0206a9faemr6144350lfh.11.1684210386760;
        Mon, 15 May 2023 21:13:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4XcgOMLWyRUrYdmvLdb0S7Ly943Vaf6XwsABKIRWswnWEAN99m8ytXLLS4m7bI20BNVt0y6deELrest0GIrjU=
X-Received: by 2002:ac2:4208:0:b0:4f0:206a:9fae with SMTP id
 y8-20020ac24208000000b004f0206a9faemr6144344lfh.11.1684210386455; Mon, 15 May
 2023 21:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230516030139.767838-1-parav@nvidia.com>
In-Reply-To: <20230516030139.767838-1-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 May 2023 12:12:55 +0800
Message-ID: <CACGkMEuyNy-JkX_Uy7TnS4qg=xmd2yjwuuLDFw6SO=dZeUe1=w@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, 
	virtio-dev@lists.oasis-open.org, shahafs@nvidia.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] content: Replace guest OS with driver

On Tue, May 16, 2023 at 11:02=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
>
> Currently device status field description and driver requirements
> section uses mix of terminology for the driver. These two sections
> sometimes call the driver as 'the guest OS' or 'the driver'.
>
> Most of the cleanup around 'guest Os' was already done around commit
> 212c0cf3 in past. Clean up the remaining few references to just
> refer it as 'driver'.
>
> This is an editorial change.
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Do we plan to replace the "hypervisor" with "device" as well?

Thanks

> ---
>  content.tex | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index 9df81b8..417d476 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -26,10 +26,10 @@ \section{\field{Device Status} Field}\label{sec:Basic=
 Facilities of a Virtio Dev
>  following bits are defined (listed below in the order in which
>  they would be typically set):
>  \begin{description}
> -\item[ACKNOWLEDGE (1)] Indicates that the guest OS has found the
> +\item[ACKNOWLEDGE (1)] Indicates that the driver has found the
>    device and recognized it as a valid virtio device.
>
> -\item[DRIVER (2)] Indicates that the guest OS knows how to drive the
> +\item[DRIVER (2)] Indicates that the driver knows how to drive the
>    device.
>    \begin{note}
>      There could be a significant (or infinite) delay before setting
> @@ -473,13 +473,13 @@ \section{Device Initialization}\label{sec:General I=
nitialization And Device Oper
>  \begin{enumerate}
>  \item Reset the device.
>
> -\item Set the ACKNOWLEDGE status bit: the guest OS has noticed the devic=
e.
> +\item Set the ACKNOWLEDGE status bit: the driver has noticed the device.
>
> -\item Set the DRIVER status bit: the guest OS knows how to drive the dev=
ice.
> +\item Set the DRIVER status bit: the driver knows how to drive the devic=
e.
>
>  \item\label{itm:General Initialization And Device Operation /
>  Device Initialization / Read feature bits} Read device feature bits, and=
 write the subset of feature bits
> -   understood by the OS and driver to the device.  During this step the
> +   understood by the driver to the device.  During this step the
>     driver MAY read (but MUST NOT write) the device-specific configuratio=
n fields to check that it can support the device before accepting it.
>
>  \item\label{itm:General Initialization And Device Operation / Device Ini=
tialization / Set FEATURES-OK} Set the FEATURES_OK status bit.  The driver =
MUST NOT accept
> --
> 2.26.2
>
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

