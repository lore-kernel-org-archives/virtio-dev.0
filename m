Return-Path: virtio-dev-return-5436-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5695985B66
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Feb 2019 16:49:38 +0000 (UTC)
References: <20190213063322.25099-1-stefanha@redhat.com>
 <20190213063322.25099-3-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8cc40ae2-e177-c606-2329-41dfe49dc600@redhat.com>
Date: Wed, 13 Feb 2019 17:49:33 +0100
MIME-Version: 1.0
In-Reply-To: <20190213063322.25099-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v2 2/2] virtio-fs: add DAX window
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 13/02/19 07:33, Stefan Hajnoczi wrote:
> Describe how shared memory region ID 0 is the DAX window and how
> FUSE_SETUPMAPPING maps file ranges into the window.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  virtio-fs.tex | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/virtio-fs.tex b/virtio-fs.tex
> index ffbaa46..37ab5ea 100644
> --- a/virtio-fs.tex
> +++ b/virtio-fs.tex
> @@ -196,3 +196,28 @@ The device MUST set \field{out.unique} to 0 and set \field{out.error} to a FUSE_
>  The driver MUST verify that \field{out.unique} is 0.
>  
>  Notifications queue buffers MUST be at least 8192 bytes long.
> +
> +\subsubsection{Device Operation: DAX Window}\label{sec:Device Types / File System Device / Device Operation / Device Operation: DAX Window}
> +
> +FUSE\_READ and FUSE\_WRITE requests transfer file contents between the
> +driver-provided buffer and the device.  In cases where data transfer is
> +undesirable, the device can map file contents into the DAX window shared memory
> +region.  The driver then accesses file contents directly in device-owned memory
> +without a data transfer.
> +
> +Shared memory region ID 0 is called the DAX window.  The driver maps a file
> +range into the DAX window using the FUSE\_SETUPMAPPING request.  The mapping is
> +removed using the FUSE\_REMOVEMAPPING request.
> +
> +After FUSE\_SETUPMAPPING has completed successfully the file range is accessible
> +from the DAX window at the offset provided by the driver in the request.

FYI: this is not upstream yet, see https://lkml.org/lkml/2018/12/10/573
for a definition.

Paolo

> +\devicenormative{\paragraph}{Device Operation: DAX Window}{Device Types / File System Device / Device Operation / Device Operation: DAX Window}
> +
> +The device MUST allow mappings that completely or partially overlap existing mappings within the DAX window.
> +
> +The device MUST reject mappings that would go beyond the end of the DAX window.
> +
> +\drivernormative{\paragraph}{Device Operation: DAX Window}{Device Types / File System Device / Device Operation / Device Operation: DAX Window}
> +
> +The driver SHOULD be prepared to find shared memory region ID 0 absent and fall back to FUSE\_READ and FUSE\_WRITE requests.
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

