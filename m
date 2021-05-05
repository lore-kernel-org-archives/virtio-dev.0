Return-Path: <virtualization-bounces@lists.linux-foundation.org>
Date: Wed, 5 May 2021 06:43:14 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Provide detailed specification of virtio-blk lifetime
 metrics
Message-ID: <20210505054314.GA4179527@infradead.org>
References: <20210420162556.217350-1-egranata@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210420162556.217350-1-egranata@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Enrico Granata <egranata@google.com>
Cc: hch@infradead.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 20, 2021 at 04:25:56PM +0000, Enrico Granata wrote:
> In the course of review, some concerns were surfaced about the
> original virtio-blk lifetime proposal, as it depends on the eMMC
> spec which is not open
> 
> Add a more detailed description of the meaning of the fields
> added by that proposal to the virtio-blk specification, as to
> make it feasible to understand and implement the new lifetime
> metrics feature without needing to refer to JEDEC's specification
> 
> This patch does not change the meaning of those fields nor add
> any new fields, but it is intended to provide an open and more
> clear description of the meaning associated with those fields.
> 
> Signed-off-by: Enrico Granata <egranata@google.com>

Still not a fan of the encoding, but at least it is properly documented
now:

Acked-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
