Return-Path: <virtio-dev-return-8812-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61CCE986503
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Oct 2021 09:00:44 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20211006112816.71892-1-jean-philippe@linaro.org>
References: <20211006112816.71892-1-jean-philippe@linaro.org>
Date: Thu, 07 Oct 2021 11:00:00 +0200
Message-ID: <878rz5yzu7.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2] content: Remove duplicate paragraph
Content-Type: text/plain
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, stefanha@redhat.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Oct 06 2021, Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> It looks like commit 356aeeb40d7a ("content: add vendor specific cfg
> type") had a merge issue. It includes the device normative paragraph for
> Shared memory capability, which was already added right above it by
> commit 855ad7af2bd6 ("shared memory: Define PCI capability").
>
> The two paragraphs differ, and the first paragraph is correct. It refers
> to struct virtio_pci_cap64 which embeds struct virtio_pci_cap:
>
>   struct virtio_pci_cap64 {
>     struct virtio_pci_cap {
>       ...
>       le32 offset;
>       le32 length;
>     } cap;
>     u32 offset_hi;
>     u32 length_hi;
>   }
>
> Merge the two paragraph while keeping the best of both. Drop the spaces
> after \field to stay consistent with the rest of the document.
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v1: https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg07815.html
> ---
>  content.tex | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)

Thanks, pushed as an editorial update.

[While looking at this, I noticed that the normative statements for the
vendor data capability are not at the correct level. I'll do a patch to
fix that.]


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

