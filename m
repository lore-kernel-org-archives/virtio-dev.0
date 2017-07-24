Return-Path: virtio-dev-return-2413-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 960BE58193D3
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Jul 2017 09:17:58 -0700 (PDT)
References: <VI1PR05MB1774022115CB7C4502DEEE73D3A10@VI1PR05MB1774.eurprd05.prod.outlook.com>
 <4DCA102C9749C849A7B61D9934ED62520B7278@fmsmsx122.amr.corp.intel.com>
 <DB5PR05MB17664614B26F6C8AA069E5B4D3A60@DB5PR05MB1766.eurprd05.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <daf6a49c-641b-38b5-17a7-588060631ddc@redhat.com>
Date: Mon, 24 Jul 2017 18:17:53 +0200
MIME-Version: 1.0
In-Reply-To: <DB5PR05MB17664614B26F6C8AA069E5B4D3A60@DB5PR05MB1766.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] RE: virtq configuration over PCI
To: Lior Narkis <liorn@mellanox.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 19/07/2017 19:56, Lior Narkis wrote:
>>> I would like to understand if I captured it right, and if so,
>>> understand how it is guaranteed today with a SW implementation of a
>>> device.

BAR writes are never pipelined or reordered.  This is probably not
helpful for HW implementations, sorry. :)

>> Guest performing queue write:
>> 1. Single write PCIe transaction with queue_select and other fields (e.g.
>> desc_addr, avail_addr) set
>> 	1.1. HW should be able to process transaction before next one (most
>> likely pipelined writes)
>> 		- however if it can't, it would just backpressure the PCIe hard
>> IP in the HW
> 
> I would not recommend back-pressuring the PCI, it will have system wide effects.
> 
> The point is not how many transactions, but the behavior of this
> special mechanism. Since there is no feedback mechanism that the
> driver can check if this configuration is completed or not, this
> memory is special. It cannot be just plain memory that stores the
> writes and responses to the reads, but needs to have a MUX logic.
Yes, queue_select needs some kind of bypass if writes are pipelined.  (I
mean bypass as in processor architecture terms, since that's the only
kind of HW that they teach you at school...).

> This is similar to the problem with doorbell(notify) writes, when a> queue numbers are written to a specific location.

I think it's different, as doorbell writes should not have a subsequent
dependency on other writes.  The doorbell is mostly a command register
(though it can be read).  The NVMe doorbells are per-queue, but I think
the completion queue doorbells do carry a "command" in the datum that
it's written to it, because you have to generate an interrupt if the
tail doesn't match the written value.

Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

