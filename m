Return-Path: <virtio-dev-return-10137-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B1E6986505
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Nov 2022 11:35:21 +0000 (UTC)
Message-ID: <ed7bbb08-afea-0383-6feb-eb434a69e070@linux.alibaba.com>
Date: Wed, 9 Nov 2022 19:35:14 +0800
MIME-Version: 1.0
From: Heng Qi <hengqi@linux.alibaba.com>
References: <20221109113257.120297-2-hengqi@linux.alibaba.com>
In-Reply-To: <20221109113257.120297-2-hengqi@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH 1/2] virtio_net: fix syntax errors
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Please ignore this email.

Thanks.

=E5=9C=A8 2022/11/9 =E4=B8=8B=E5=8D=887:32, Heng Qi =E5=86=99=E9=81=93:
> From: Heng Qi <henqqi@linux.alibaba.com>
>
> \field{hash_types} can contain multiple bitmasks.
>
> Signed-off-by: Heng Qi <henqqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   content.tex | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index e863709..6fabf1d 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3210,7 +3210,7 @@ \subsection{Device configuration layout}\label{sec:=
Device Types / Network Device
>   The next field, \field{supported_hash_types} only exists if the device =
supports hash calculation,
>   i.e. if VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
>  =20
> -Field \field{supported_hash_types} contains the bitmask of supported has=
h types.
> +Field \field{supported_hash_types} contains the bitmasks of supported ha=
sh types.
>   See \ref{sec:Device Types / Network Device / Device Operation / Process=
ing of Incoming Packets / Hash calculation for incoming packets / Supported=
/enabled hash types} for details of supported hash types.
>  =20
>   \devicenormative{\subsubsection}{Device configuration layout}{Device Ty=
pes / Network Device / Device configuration layout}
> @@ -4369,7 +4369,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
>       u8 hash_key_data[hash_key_length];
>   };
>   \end{lstlisting}
> -Field \field{hash_types} contains a bitmask of allowed hash types as
> +Field \field{hash_types} contains bitmasks of allowed hash types as
>   defined in
>   \ref{sec:Device Types / Network Device / Device Operation / Processing =
of Incoming Packets / Hash calculation for incoming packets / Supported/ena=
bled hash types}.
>   Initially the device has all hash types disabled and reports only VIRTI=
O_NET_HASH_REPORT_NONE.
> @@ -4398,7 +4398,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
>       u8 hash_key_data[hash_key_length];
>   };
>   \end{lstlisting}
> -Field \field{hash_types} contains a bitmask of allowed hash types as
> +Field \field{hash_types} contains bitmasks of allowed hash types as
>   defined in
>   \ref{sec:Device Types / Network Device / Device Operation / Processing =
of Incoming Packets / Hash calculation for incoming packets / Supported/ena=
bled hash types}.
>  =20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

