Return-Path: virtio-dev-return-5091-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8DA0985D6D
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Nov 2018 09:00:58 +0000 (UTC)
Date: Fri, 30 Nov 2018 10:00:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181130100052.0a22ea72.cohuck@redhat.com>
In-Reply-To: <20181129181659.21284-1-stefanha@redhat.com>
References: <20181129181659.21284-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v10] vsock: add vsock device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Ian Campbell <ian.campbell@docker.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 29 Nov 2018 18:16:59 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> The virtio vsock device is a zero-configuration socket communications
> device.  It is designed as a guest<->host management channel suitable
> for communicating with guest agents.
> 
> vsock is designed with the sockets API in mind and the driver is
> typically implemented as an address family (at the same level as
> AF_INET).  Applications written for the sockets API can be ported with
> minimal changes (similar amount of effort as adding IPv6 support to an
> IPv4 application).
> 
> Unlike the existing console device, which is also used for guest<->host
> communication, multiple clients can connect to a server at the same time
> over vsock.  This limitation requires console-based users to arbitrate
> access through a single client.  In vsock they can connect directly and
> do not have to synchronize with each other.
> 
> Unlike network devices, no configuration is necessary because the device
> comes with its address in the configuration space.
> 
> The vsock device was prototyped by Gerd Hoffmann and Asias He.  I picked
> the code and design up from them.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/27
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

I have not reviewed it in detail; but in general, the spec looks good
to me.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

