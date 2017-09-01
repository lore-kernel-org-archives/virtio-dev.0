Return-Path: virtio-dev-return-2506-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 54F675818D9B
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Sep 2017 04:45:59 -0700 (PDT)
References: <1503734014-239116-1-git-send-email-longpeng2@huawei.com>
 <59A8AE20.1080409@huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 1 Sep 2017 13:45:45 +0200
MIME-Version: 1.0
In-Reply-To: <59A8AE20.1080409@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <7f0b8eb2-9e5c-7507-191d-1aab17c6ff0f@linux.vnet.ibm.com>
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v19 0/2] virtio-crypto: virtio crypto device
 specification
To: "Longpeng (Mike)" <longpeng2@huawei.com>, stefanha@redhat.com
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, mst@redhat.com, cohuck@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, nmorey@kalray.eu, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, wangxinxin.wang@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 09/01/2017 02:47 AM, Longpeng (Mike) wrote:
> Ping...
> 
> Stefan, Halil, do you have any suggestion ?
> 

Hi Longpeng,

I've ran trough your patch, and it reads much better that
what I recall v18 used to read like. Because it's been a while
since v18 doing a conscious review on this will take a considerable
amount of time (my memories of the issues identified back then
are very sketchy/vague now). It's on my todo list, but it ain't the
only item there.

Btw. I like to have a reference implementation at hand when reviewing
a spec. What is the status of the (reference) implementation (I mean
the new stuff like stateless/mux)? I think it would be nice to provide
this info in the cover letter (e.g. next time, should we need another
iteration).

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

