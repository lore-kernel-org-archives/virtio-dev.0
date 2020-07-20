Return-Path: virtio-dev-return-7596-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0C13E98431B
	for <virtio-dev@lists.oasis-open.org>; Mon, 20 Jul 2020 08:53:17 +0000 (UTC)
References: <20200713203539.17140.71425.stgit@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ce128be5-4756-bb7b-719b-c172cf380fd8@redhat.com>
Date: Mon, 20 Jul 2020 10:53:08 +0200
MIME-Version: 1.0
In-Reply-To: <20200713203539.17140.71425.stgit@localhost.localdomain>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] virtio-balloon: Document byte ordering of
 poison_val
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 13.07.20 22:35, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> The poison_val field in the virtio_balloon_config is treated as a
> little-endian field by the host. Since we are currently only having to deal
> with a single byte poison value this isn't a problem, however if the value
> should ever expand it would cause byte ordering issues. Document that in
> the code so that we know that if the value should ever expand we need to
> byte swap the value on big-endian architectures.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/virtio/virtio_balloon.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 1f157d2f4952..d0fd8f8dc6ed 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -974,6 +974,11 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  		/*
>  		 * Let the hypervisor know that we are expecting a
>  		 * specific value to be written back in balloon pages.
> +		 *
> +		 * If the PAGE_POISON value was larger than a byte we would
> +		 * need to byte swap poison_val here to guarantee it is
> +		 * little-endian. However for now it is a single byte so we
> +		 * can pass it as-is.

Yeah, why not (although it's pretty fundamental that 1-byte values don't
need any swapping).

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

