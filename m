Return-Path: virtio-dev-return-5237-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A0BC5985AFA
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Jan 2019 12:18:34 +0000 (UTC)
Date: Thu, 3 Jan 2019 13:18:24 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <1546493462-32244-3-git-send-email-wei.w.wang@intel.com>
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
	<1546493462-32244-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190103131824.692d0404@oc2783563651>
Subject: [virtio-dev] Re: [PATCH v1 2/2] virtio-balloon: improve update_balloon_size_func
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu,  3 Jan 2019 13:31:02 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> There is no need to update the balloon actual register when there is no
> ballooning request. This patch avoids update_balloon_size when diff is 0.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

I would be also fine with both patches squashed into one.

BTW the end result looks to me even a bit nicer.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

