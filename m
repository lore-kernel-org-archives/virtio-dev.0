Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <f8b0ea37-8721-5ca4-f6d7-37770728beec@nvidia.com>
Date: Wed, 2 Feb 2022 12:52:47 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Reserve more feature bits for device type usage
References: <20220114111210.129059-1-cohuck@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220114111210.129059-1-cohuck@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 1/14/2022 1:12 PM, Cornelia Huck wrote:
> Feature bits 41 and above are noted as being reserved for future
> extensions. However, the net device has been using bits in that space
> for some time now, as it already used up the device type specific
> range up to 23.
>
> To avoid problems in the future, let's designate bits 50 to 127 to
> device type specific usage (which accommodates current usage by the
> net driver, and gives breathing room for future type specific bits),
> and declare bits 41 to 49 and bits 128 and above to be reserved for
> future extensions (which gives us some time before bit numbers move
> beyond 63, which would need some changes in existing device and driver
> implementations.)
>
> Reported-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/131
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   content.tex | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index 32de6685c50b..c6f116c7aa39 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -97,12 +97,12 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>   Feature bits are allocated as follows:
>   
>   \begin{description}
> -\item[0 to 23] Feature bits for the specific device type
> +\item[0 to 23, and 50 to 127] Feature bits for the specific device type
>   
>   \item[24 to 40] Feature bits reserved for extensions to the queue and
>     feature negotiation mechanisms
>   
> -\item[41 and above] Feature bits reserved for future extensions.
> +\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
>   \end{description}
>   
>   \begin{note}

Cornelia,

I've noticed that Legacy net device has VIRTIO_NET_F_GUEST_RSC4 (41) and 
VIRTIO_NET_F_GUEST_RSC6 (42).

Do we need to reserved them too or keep the fix as-is ?


