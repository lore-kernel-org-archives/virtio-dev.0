Return-Path: <virtio-dev-return-14302-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBBBC4829A
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Feb 2024 12:43:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 02B212B03A
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Feb 2024 12:43:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8B7B986549
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Feb 2024 12:43:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BFECA986495; Tue, 13 Feb 2024 12:43:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC7E6986497
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Feb 2024 12:43:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2NlCyDb4OOiUzfLLYZInxA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>, virtio-dev@lists.oasis-open.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
In-Reply-To: <ac39845f39f1fb17281cfe6472dff590a04e7683.1706602613.git.viresh.kumar@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <ac39845f39f1fb17281cfe6472dff590a04e7683.1706602613.git.viresh.kumar@linaro.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 13 Feb 2024 13:43:41 +0100
Message-ID: <87a5o4h6v6.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH V2] virtio-transport: Clarify requirements

On Tue, Jan 30 2024, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> The virtio documentation currently doesn't define any generic
> requirements that are applicable to all transports. They can be useful
> while adding support for a new transport.
>
> This commit tries to define the same.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2:
> - Lot of changes after discussions with Alex and Cornelia.
> - Almost a rewrite of the first commit.
> - Add Transport normative sections.
>
>  commands.tex    |  1 +
>  conformance.tex | 14 +++++++++
>  content.tex     | 78 +++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 91 insertions(+), 2 deletions(-)
>
> diff --git a/commands.tex b/commands.tex
> index 25ea8ee3bc78..692ef0833a88 100644
> --- a/commands.tex
> +++ b/commands.tex
> @@ -8,6 +8,7 @@
>  \newcommand{\field}[1]{\emph{#1}}
>  
>  % Mark a normative section (driver or device)

Nit: driver, device, or transport

> +\newcommand{\transportnormative}[3]{#1{Transport Requirements: #2}\label{transportnormative:#3}}
>  \newcommand{\drivernormative}[3]{#1{Driver Requirements: #2}\label{drivernormative:#3}}
>  \newcommand{\devicenormative}[3]{#1{Device Requirements: #2}\label{devicenormative:#3}}
>  \newcounter{clausecounter}
> diff --git a/conformance.tex b/conformance.tex
> index dc00e84e75ae..9bb1c9e2f6ec 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -11,6 +11,10 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  
>  Conformance targets:
>  \begin{description}
> +\item[Transport] A transport MUST conform to following conformance clauses:

Maybe "MUST conform to one conformance clause"?

> +  \begin{itemize}
> +    \item Clause \ref{sec:Conformance / Transport Conformance}.
> +  \end{itemize}
>  \item[Driver] A driver MUST conform to four conformance clauses:
>    \begin{itemize}
>      \item Clause \ref{sec:Conformance / Driver Conformance}.

(...)

Apart from the nits above, this looks good to me.

I'd be in favour of initiating a vote for this, after the OASIS
infrastructure migragion has completed and we have dealt with any
fallout from that... that would probably mean March :(

(Oh, and this should probably go to virtio-comment as well.)

[Apologies for not reviewing earlier, but I'm struggling to keep afloat,
and the OASIS infrastructure saga did not exactly help...]


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

