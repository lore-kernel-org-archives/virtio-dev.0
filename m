Return-Path: virtio-dev-return-6426-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79FCE985ECB
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 Nov 2019 19:12:56 +0000 (UTC)
References: <20191128131941.25069-1-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <43ca5852-e86c-d502-b6e5-482513f95ff9@redhat.com>
Date: Thu, 28 Nov 2019 20:12:46 +0100
MIME-Version: 1.0
In-Reply-To: <20191128131941.25069-1-kraxel@redhat.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] virtio-gpu: add shared resource feature
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/28/19 14:19, Gerd Hoffmann wrote:

> +resources.  Normal resources have both a guest buffer and host buffer
> +buffer for the resource and the VIRTIO_GPU_CMD_TRANSFER_* commands are

typo: "buffer\nbuffer"

Thanks
Laszlo


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

