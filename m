Return-Path: <virtio-dev-return-14324-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC1DC48BEB
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Feb 2024 11:09:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4F8867C1AB
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Feb 2024 11:09:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1D8B3986668
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Feb 2024 11:09:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F09589865FD; Fri, 16 Feb 2024 11:09:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E1C15986602
	for <virtio-dev@lists.oasis-open.org>; Fri, 16 Feb 2024 11:09:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Om2yKeRtMS-jnZAO24u_lA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 linux-can@vger.kernel.org
Cc: Harald Mommer <harald.mommer@opensynergy.com>, Mikhail Golubev-Ciuchea
 <Mikhail.Golubev-Ciuchea@opensynergy.com>
In-Reply-To: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Fri, 16 Feb 2024 12:08:56 +0100
Message-ID: <87sf1sfyyf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Subject: Re: [virtio-dev] [RFC PATCH v3] virtio-can: Device specification.

On Fri, Jun 09 2023, Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:

> From: Harald Mommer <harald.mommer@opensynergy.com>
>
> virtio-can is a virtual CAN device. It provides a way to give access to
> a CAN controller from a driver guest. The device is aimed to be used by
> driver guests running a HLOS as well as by driver guests running a
> typical RTOS as used in controller environments.
>
> Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
> Signed-off-by: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>

(...)

> diff --git a/device-types/can/device-conformance.tex b/device-types/can/device-conformance.tex
> new file mode 100644
> index 0000000..f944ffd
> --- /dev/null
> +++ b/device-types/can/device-conformance.tex
> @@ -0,0 +1,8 @@
> +\conformance{\subsection}{CAN Device Conformance}\label{sec:Conformance / Device Conformance / CAN Device Conformance}
> +
> +A CAN device MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / CAN Device / Feature bits}

I just noticed that this introduces[1] an undefined reference (there's no
device normative section for feature bits.) I'd suggest to just drop
this reference (I can do that as a simple editorial update); if we want
to have an actual normative reference for feature bits, it should be
done via an extra change on top.

> +\item \ref{devicenormative:Device Types / CAN Device / Device Operation / CAN Message Transmission}
> +\end{itemize}

[1] Easy to miss, as the current 1.4 branch has a pre-existing undefined
reference, which will go away once we finally can merge into the main
branch again and have all that craziness go away after we manage to do
the actual 1.3 release :/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

