Return-Path: virtio-dev-return-4361-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0ED2D1CB80ED
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Jun 2018 02:06:07 -0700 (PDT)
Date: Wed, 13 Jun 2018 11:05:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180613110552.7a097717.cohuck@redhat.com>
In-Reply-To: <20180612053221.22925-1-tiwei.bie@intel.com>
References: <20180612053221.22925-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC] content: use a consistent wording for device status
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 12 Jun 2018 13:32:21 +0800
Tiwei Bie <tiwei.bie@intel.com> wrote:

> There is a part called "device status field" in a
> Virtio device. Currently, both of \field{status}
> and \field{device status} are used to refer to it,
> which is a bit confusing. This patch changes spec
> to use \field{device status} consistently.
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
> If we want this change, I'll open an issue and
> send a formal patch.

Sounds good, given that there are some device-type specific 'status'
fields, which makes things confusing.

> 
>  content.tex | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Patch looks good.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

