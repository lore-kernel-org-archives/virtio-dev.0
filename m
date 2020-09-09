Return-Path: virtio-dev-return-7769-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 94096985D3E
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Sep 2020 07:04:02 +0000 (UTC)
Date: Wed, 9 Sep 2020 09:03:49 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200909070349.uyvg44xakdftibxh@sirius.home.kraxel.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
 <20200902210847.2689-5-gurchetansingh@chromium.org>
 <20200902221514.GE1263242@redhat.com>
 <CAAfnVBnfbwc07au1OMec8g5yHC0D3yXc88nOtTopO4sitYf8ig@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAfnVBnfbwc07au1OMec8g5yHC0D3yXc88nOtTopO4sitYf8ig@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2 04/23] virtio: Add get_shm_region method
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Vivek Goyal <vgoyal@redhat.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, virtio-dev@lists.oasis-open.org, Sebastien Boeuf <sebastien.boeuf@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 02, 2020 at 05:00:25PM -0700, Gurchetan Singh wrote:
> On Wed, Sep 2, 2020 at 3:15 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > Hi Gurchetan,
> >
> > Now Miklos has queued, these tree virtio patches for shared memory
> > region in his tree as part of virtiofs dax patch series.
> >
> > I am hoping this will get merged in 5.10 through his tree.
> >
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?h=dax
> 
> 
> Terrific ... !  Maybe we can queue the version Miklos has in drm-misc-next
> to avoid merge conflicts ?!?

I guess it would either be merging the fuse tree into drm-misc-next,
or cherry-picking the three virtio shm patches from the fuse tree.

Daniel?  What is the usual way to handle this?

thanks,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

