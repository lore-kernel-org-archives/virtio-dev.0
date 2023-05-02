Return-Path: <virtio-dev-return-12490-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76A0C77B7E
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 07:39:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7099F71CA3
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 07:39:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D5339864A5
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 07:39:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5120D986479; Tue,  2 May 2023 07:39:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E77B986485
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 May 2023 07:39:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: codtqShFMD6DDjsWkq1Q0g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683013186; x=1685605186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFWTgrXjIdJ5Rb0A7mi6Z36YsKeowQRD/5Nd+SivRcE=;
        b=Rk/HYJ/U/1F1c8+J3U6kfYkL7uli24dmeqCIba+M/29xQNJoCv1DnVnq3FW3Dn6Esl
         mTP/128lz4OeU6yjKavvOuQoO/SLTNd2BbckoJd/brwU5LeqRu/SEsrpiHgt3lLXN87P
         BTG4ATUJDWZORWYFOMU9hOczcbVJdiPi0i2XdsCF8MFl79ibpn/plTUzlaOmWu31HGDy
         AsiJa6b/D/MnZ4TlEVUYq31CwPirWXEUZ10p8qwer6lNAbfJ2GGJK+/gKKIyh1HoESv0
         wxoanSq+tr5qxgCVwWqA4AL1O9cHzCbMqpFXc59nvR1UJlMFOeTMMCtWXs3p5z2KZ2uJ
         w3RQ==
X-Gm-Message-State: AC+VfDwoOVGf219b3rilVe2GKRBTUVMheQNt8+h3rdTyWW/Bh6u25bGF
	QV+fkPd9tRasIdlpt//K+JWEy53r8QfCYkGglcCngDEAx5LZyklfgQgi0n1qCJPJ+FnoY3mTTIh
	eeTcBSN6ABsqzvyLlw8aEMfhwPW4c
X-Received: by 2002:a7b:cc89:0:b0:3eb:39e2:915b with SMTP id p9-20020a7bcc89000000b003eb39e2915bmr11498476wma.31.1683013186449;
        Tue, 02 May 2023 00:39:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52fTcq8AFbUxku9WeZKxJjgRTnRuB1SwDTGlRDVvMSn5lnhcPCorcq4RZHo0tPUR7udoUFkw==
X-Received: by 2002:a7b:cc89:0:b0:3eb:39e2:915b with SMTP id p9-20020a7bcc89000000b003eb39e2915bmr11498465wma.31.1683013186160;
        Tue, 02 May 2023 00:39:46 -0700 (PDT)
Date: Tue, 2 May 2023 03:39:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230502033812-mutt-send-email-mst@kernel.org>
References: <20230501224430.485139-1-parav@nvidia.com>
 <20230501224430.485139-2-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230501224430.485139-2-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 1/2] admin: Remove dependency on the deprecated register

On Tue, May 02, 2023 at 01:44:29AM +0300, Parav Pandit wrote:
> 'VF Migration Capable' is already deprecated as per
> PCI base specification 6.0.1 section 9.3.3.2.1.
> It was long ago deprecated which was meant for MR-IOV.
> 
> Hence, remove virtio PCI specification to not depend
> on such deprecated bits.
> 
> This patch is on top of [1].
> 
> [1] https://lore.kernel.org/virtio-comment/cover.1682354275.git.mst@redhat.com/T/#t
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>

OK you know best I guess. I will drop mentions of VF Migration Capable.

> ---
>  admin.tex | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/admin.tex b/admin.tex
> index 2efd4d7..037e2e6 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -372,9 +372,8 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL and
>  \field{status_qualifier} set to
>  VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER;
> -\field{NumVFs}, \field{VF Migration Capable}  and
> -\field{VF Enable} refer to registers within the SR-IOV Extended
> -Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
> +\field{NumVFs} and \field{VF Enable} refer to registers within the
> +SR-IOV Extended Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
>  
>  \drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
>  
> @@ -423,11 +422,9 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  the driver specify a value for \field{group_member_id}
>  between $1$ and \field{NumVFs} inclusive,
>  the driver MUST also make sure that as long as any such command
> -is outstanding, \field{VF Migration Capable} is clear and
> -\field{VF Enable} is set;
> -\field{NumVFs}, \field{VF Migration Capable}  and
> -\field{VF Enable} refer to registers within the SR-IOV Extended
> -Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
> +is outstanding, is clear and \field{VF Enable} is set;
> +\field{NumVFs} and \field{VF Enable} refer to registers within the
> +SR-IOV Extended Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
>  
>  \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
>  
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

