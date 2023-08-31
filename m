Return-Path: <virtio-dev-return-13591-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B48DC83F10
	for <virtio-dev@archiver.kernel.org>; Thu, 31 Aug 2023 10:16:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 935E27E90E
	for <virtio-dev@archiver.kernel.org>; Thu, 31 Aug 2023 10:16:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F747986572
	for <virtio-dev@archiver.kernel.org>; Thu, 31 Aug 2023 10:16:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 51C9F986546; Thu, 31 Aug 2023 10:16:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E778986542;
	Thu, 31 Aug 2023 10:16:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=Sophos;i="6.02,216,1688428800"; 
   d="scan'208";a="302455000"
Message-ID: <0abb7518-16e0-4227-bfe1-a29bd27124e8@amazon.es>
Date: Thu, 31 Aug 2023 12:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Michael S. Tsirkin" <mst@redhat.com>,
	<virtio-comment@lists.oasis-open.org>, <virtio-dev@lists.oasis-open.org>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>, "Graf (AWS), Alexander"
	<graf@amazon.de>, "Jason A. Donenfeld" <Jason@zx2c4.com>, <aams@amazon.de>
References: <20221121162756.350032-1-mst@redhat.com>
 <20221121162756.350032-4-mst@redhat.com>
Content-Language: en-US
From: Babis Chalios <bchalios@amazon.es>
Autocrypt: addr=bchalios@amazon.es; keydata=
 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
In-Reply-To: <20221121162756.350032-4-mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.1.212.24]
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)
Subject: Re: [virtio-dev] [PATCH RFC 3/3] rng: leak detection support

Hi Michael,

On 21/11/22 17:30, Michael S. Tsirkin wrote:
> Add virtqueues to support reporting entropy leaks (similar to virtio based vmgenid).
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   virtio-rng.tex | 61 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/virtio-rng.tex b/virtio-rng.tex
> index 1ec7164..4760dfa 100644
> --- a/virtio-rng.tex
> +++ b/virtio-rng.tex
> @@ -9,10 +9,14 @@ \subsection{Device ID}\label{sec:Device Types / Entropy Device / Device ID}
>   \subsection{Virtqueues}\label{sec:Device Types / Entropy Device / Virtqueues}
>   \begin{description}
>   \item[0] requestq
> +\item[1] leakq1 (only if VIRTIO_RNG_F_LEAK is offered)
> +\item[2] leakq2 (only if VIRTIO_RNG_F_LEAK is offered)
>   \end{description}
>   
>   \subsection{Feature bits}\label{sec:Device Types / Entropy Device / Feature bits}
> -  None currently defined
> +\begin{description}
> +\item[VIRTIO_RNG_F_LEAK (0)] Device can report and handle information leaks.
> +\end{description}
>   
>   \subsection{Device configuration layout}\label{sec:Device Types / Entropy Device / Device configuration layout}
>     None currently defined.
> @@ -21,6 +25,7 @@ \subsection{Device Initialization}\label{sec:Device Types / Entropy Device / Dev
>   
>   \begin{enumerate}
>   \item The \field{requestq} virtqueue is initialized
> +\item If VIRTIO_RNG_F_LEAK has been negotiated, \field{leakq1} and \field{leakq2} are initialized
>   \end{enumerate}
>   
>   \subsection{Device Operation}\label{sec:Device Types / Entropy Device / Device Operation}
> @@ -41,3 +46,57 @@ \subsection{Device Operation}\label{sec:Device Types / Entropy Device / Device O
>   The device MUST place one or more random bytes into the buffer
>   made available to it through \field{requestq}, but it
>   MAY use less than the entire buffer length.
> +
> +\subsubsection{Reporting Information Leaks}{Device Types / Entropy Device / Device Operation / Reporting Information Leaks}
> +
> +The device might, after the fact, detect that some of the entropy
> +it supplied to the driver has after the fact degraded in quality
> +or leaked to the outside world.  One example is when the device
> +is part of the virtual machine undergoing a restore from snapshot
> +operation. Another example is when the information leaks from the
> +host system through a side-channel.
> +
> +The driver would typically react by causing regeneration of any
> +information that might have leaked and that has to be secret or
> +unique.  It is understood that when an information leak has been
> +detected it is likely not limited to the entropy received through
> +the specific device. In particular, this is the case for
> +snapshoting It is thus suggested that the system fully
> +regenerate any unique/secret information in this scenario.
> +
> +If VIRTIO_RNG_F_LEAK has been negotiated the device can report
> +such leaks to the driver through a set of dedicated leak
> +queues: \field{leakq1} and \field{leakq2}.
> +
> +Buffers added to the leak queues can have one of two forms:
> +\begin{enumerate}
> +\item A write-only buffer. It will be completely filled by random data by the device.
> +\item A buffer consisting of read-only section followed by a
> +write-only section, both of identical size. The
> +device will copy data from the read-only section to the write-only
> +section.
> +\end{enumerate}
> +
> +The steps for operating the virtqueue are:
> +
> +\begin{enumerate}
> +\item At each time, only one of \field{leakq1}, \field{leakq2} is active
> +      (has buffers added/used).
> +\item After initialization, \field{leakq1} is active.
> +\item Driver adds multiple buffers to the active leak queue.
> +\item The buffers are not used until an information leak is
> +      detected, as long as that is the case driver can
> +      add more buffers to the active queue.
> +\item Upon detecting an information leak, device starts
> +      using buffers in the active leak queue.
> +\item Upon detecting that buffers have been used, driver
> +      switches to another leak queue making it active
> +      (e.g. from \field{leakq1} to \field{leakq2} or vice versa).
> +      It then starts adding buffers to the new leak queue.\

I have been discussing with Alex and we think there's a potential race 
here, between the time the driver
sees the used buffers in the active leak queue until the time it adds 
new buffers to the next leak queue.
If a new entropy leak event arrives the VMM won't find any buffers in 
the queue.

In the last RFC implementing this in Linux we sent to LKML [1] we avoid 
the issue by pre-populating both
queues, but that does not solve the problem if a third entropy leak 
event arrives. The probability of this
happening is indeed small, but we thought of a potential solution to this.

What if we modify the spec here to instruct the VMM to deny taking a 
snapshot if there are not any buffers
in the active leak queue? If we did this, we could even simplify the 
spec to just introduce a single entropy
leak queue, so we could avoid the complexity of switching between active 
leak queues in the driver and
the device. WDYT?

Cheers,
Babis

[1] 
https://lore.kernel.org/lkml/20230823090107.65749-3-bchalios@amazon.es/T/

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

