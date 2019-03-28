Return-Path: virtio-return-3331-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 28 Mar 2019 13:36:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190328133358-mutt-send-email-mst@kernel.org>
References: <20190327223250.11292-1-mst@redhat.com>
 <9053d174912940588578675fb17e1069@napatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9053d174912940588578675fb17e1069@napatech.com>
Subject: [virtio] Re: [virtio-dev] [PATCH v2] acknowledgements: add members and
 non-members
To: Lars Ganrot <lga@napatech.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Sure, will do.  And which affiliation should I list? Napatech?

On Thu, Mar 28, 2019 at 10:06:20AM +0000, Lars Ganrot wrote:
> Hi Michael,
> 
> (Sending this to your account, not the list, since it isn't of general interest).
> 
> I have no knowledge of the community's threshold for acknowledging non-members, but would like to ensure my contribution regarding VIRTIO_F_IN_ORDER (attached)  is not left out by accident.
> 
> If too minor for inclusion, I gracefully accept that decision.
> 
> Best Regards,
> 
> -Lars
> 
> -----Original Message-----
> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On Behalf Of Michael S. Tsirkin
> Sent: 27. marts 2019 23:33
> To: virtio@lists.oasis-open.org; virtio-dev@lists.oasis-open.org
> Subject: [virtio-dev] [PATCH v2] acknowledgements: add members and non-members
> 
> Add all current members as participants.
> Add all participant names collected from list, jira and github.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Fixes from v1:
> add two reporters from mailing list (mellanox)
> 
>  acknowledgements.tex | 72 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 63 insertions(+), 9 deletions(-)
> 
> diff --git a/acknowledgements.tex b/acknowledgements.tex index 233e4a1..b2feeaf 100644
> --- a/acknowledgements.tex
> +++ b/acknowledgements.tex
> @@ -6,47 +6,101 @@ \chapter{Acknowledgements}\label{chap:Acknowledgements}
>  The following individuals have participated in the creation of this specification and are gratefully acknowledged:
> 
>  \begin{oasistitlesection}{Participants}
> +Allen Chia, Oracle\newline
>  Amit Shah,Red Hat\newline
>  Amos Kong,Red Hat\newline
>  Anthony Liguori,IBM\newline
> -Bruce Rogers,Novell\newline
> +Bruce Rogers, SUSE\newline
>  Bryan Venteicher,NetApp\newline
> +Chandra Thyamagondlu, Xilinx\newline
> +Chet Ensign, OASIS\newline
>  Cornelia Huck,Red Hat\newline
> +Cunming, Liang, Intel\newline
> +Damjan, Marion, Cisco\newline
>  Daniel Kiper,Oracle\newline
> +Fang Chen, Huawei\newline
> +Fang You, Huawei\newline
>  Geoff Brown,Machine-to-Machine Intelligence (M2MI) Corporation\newline
> +Gerd Hoffmann, Red Hat\newline
>  Gershon Janssen,Individual Member\newline
> +Grant Likely, ARM\newline
> +Haggai Eran,Mellanox\newline
>  Halil Pasic,IBM\newline
>  James Bottomley,Parallels IP Holdings GmbH\newline
> +Jani Kokkonen, Huawei\newline
> +Jan Kiszka,Siemens AG\newline
> +Jens Freimann, Red Hat\newline
>  Jian Zhou,Huawei\newline
> +Karen Xie, Xilinx\newline
> +Kumar Sanghvi, Xilinx\newline
>  Lei Gong,Huawei\newline
> +Lior Narkis,Mellanox\newline
>  Luiz Capitulino,Red Hat\newline
> +Marc-André Lureau, Red Hat\newline
> +Mark Gray, Intel\newline
>  Michael S. Tsirkin,Red Hat\newline
> +Mihai Carabas,Oracle\newline
> +Nishank Trivedi, NetApp\newline
>  Paolo Bonzini,Red Hat\newline
> -Pawel Moll,ARM \newline
> +Paul Mundt, Huawei\newline
> +Pawel Moll,ARM\newline
>  Peng Long,Huawei\newline
> -Richard Sohn,Alcatel-Lucent \newline
> +Piotr Uminski, Intel\newline
> +Qian Xum, Intel\newline
> +Richard Sohn,Alcatel-Lucent\newline
>  Rusty Russell,IBM\newline
>  Sasha Levin,Oracle\newline
>  Sergey Tverdyshev,Thales e-Security\newline
>  Stefan Hajnoczi,Red Hat\newline
> +Sundar Mohan, Xilinx\newline
>  Tom Lyon,Samya Systems, Inc.\newline
> +Victor Kaplansky, Red Hat\newline
> +Vijay Balakrishna,Oracle\newline
> +Wei Wang, Intel\newline
> +Xin Zeng, Intel\newline
>  \end{oasistitlesection}
> 
>  The following non-members have provided valuable feedback on this  specification and are gratefully acknowledged:
> 
>  \begin{oasistitlesection}{Reviewers}
> +Aaron Conole,Red Hat\newline
>  Andrew Thornton,  Google \newline
>  Arun Subbarao,LynuxWorks\newline
> +Baptiste Reynal,Virtual Open Systems\newline
>  Brian Foley,  ARM \newline
> +Changpeng Liu,Intel\newline
> +Christian Pinto,Virtual Open Systems\newline
> +Christoffer Dall,ARM\newline
> +Christian Borntraeger,IBM\newline
> +Daniel Marcovitch,Mellanox\newline
>  David Alan Gilbert, Red Hat \newline
> +David Hildenbrand,Red Hat\newline
>  Fam Zheng, Red Hat\newline
> -Gerd Hoffmann, Red Hat\newline
> -Halil Pasic,IBM\newline
> +Gil Savir,Intel\newline
> +Gonglei (Arei),Huawei\newline
> +Hannes Reiencke, SUSE\newline
> +Jacques Durand,Fujutsu\newline
>  Jason Wang, Red Hat \newline
> -Laura Novich, Red Hat\newline
> -Patrick Durusau,Technical Advisory Board, OASIS\newline
> -Thomas Huth,Red Hat\newline
> -Yan Vugenfirer, Red Hat / Daynix\newline
> +Jean-Philippe Brucker,ARM\newline
> +Jonathan Helman,Oracle\newline
>  Kevin Lo,MSI\newline
> +Laura Novich, Red Hat\newline
> +Ladi Prosek,Red Hat\newline
> +Longpeng (Mike),Huawei\newline
> +Maxime Coquelin,Red Hat\newline
> +Namhyung Kim,LG\newline
> +Patrick Durusau,Technical Advisory Board, OASIS\newline
> +Robin Cover,Technical Advisory Board, OASIS\newline
> +Sameeh Jubran,Red Hat / Daynix\newline
> +Sridhar Samudrala,Intel\newline
> +Stefano Garzarella,Red Hat\newline
> +Thomas Huth,Red Hat\newline
> +Tiwei Bie,Intel\newline
> +Tomáš Golembiovský,Red Hat\newline
> +Victor Kaplansky,Red Hat\newline
> +Yan Vugenfirer, Red Hat / Daynix\newline
> +Will Deacon,ARM\newline
> +Yuri Benditovich,Red Hat / Daynix\newline
> +Zhoujian,Huawei\newline
>  \end{oasistitlesection}
> --
> MST
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
> Disclaimer: This email and any files transmitted with it may contain confidential information intended for the addressee(s) only. The information is not to be surrendered or copied to unauthorized persons. If you have received this communication in error, please notify the sender immediately and delete this e-mail from your system.

> Date: Fri, 20 Oct 2017 09:50:03 +0000
> From: Lars Ganrot <lga@napatech.com>
> To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
> Subject: Re: [virtio-dev] packed ring layout proposal v3
> Message-ID: <ea698aaf8a2c40c0a8904485831f52ab@napatech.com>
> 
> Hi Michael,
> 
> I'm trying to understand your Sep 28 13:32 example (text copied below). I've in-lined my questions [#lga#].
> 
> >
> > Let's assume device promised to consume packets in order
> >
> > ring size = 2
> >
> > Ring is 0 initialized.
> >
> > Device initially polls DESC[0].flags for WRAP bit to change.
> >
> > driver adds:
> >
> > DESC[0].addr = 1234
> > DESC[0].id = 0
> > DESC[0].flags = DESC_DRIVER | DESC_MORE | DESC_WRAP
> >
> > and
> >
> > DESC[0].addr = 5678
> 
> [#lga#] Is index 0 above a typo (makes more sense if it is 1)?
> 
> > DESC[1].id = 1
> > DESC[1].flags = DESC_DRIVER | DESC_WRAP
> >
> > it now starts polling DESC[0] flags.
> >
> > Device reads 1234, executes it, does not use it.
> >
> > Device reads 5678, executes it, and uses it:
> >
> > DESC[0].id = 1
> > DESC[0].flags = 0
> 
> [#lga#] Should above line be: "DESC[0].flags =  DESC[1].flags  & DESC_WRAP"?
> 
> >
> > Device now polls DESC[0].flags for WRAP bit to change.
> >
> > Now driver sees that DRIVER bit has been cleared, so it nows that id
> > is valid. I sees id 1, therefore id 0 and 1 has been read and are safe to overwrite.
> 
> [#lga#] At this point, has the device returned both buffers *(1234) and *(5678) to the driver?
> [#lga#] If so, how would out-of-order completion avoid head of line blocking?
> [#lga#] E.g. the device is done with id=1 and *(5678), but not id=0 and *(1234).
> 
> >
> > So it writes it out. It wrapped around to beginning of ring, so it
> > flips the WRAP bit to 0 on all descriptors now:
> >
> > DESC[0].addr = 9ABC
> > DESC[0].id = 0
> > DESC[0].flags = DESC_DRIVER | DESC_MORE
> >
> > DESC[0].addr = DEF0
> > DESC[0].id = 1
> > DESC[0].flags = DESC_DRIVER
> 
> [#lga#] Index typo in all 3 lines above? DESC[1] makes more sense.
> 
> >
> > Next round wrap will be 1 again.
> >
> > To summarise:
> >
> > DRIVER bit is used by driver to detect device has used one or more
> > descriptors.  WRAP is is used by device to detect driver has made a
> > new descriptor available.
> 
> Best Regards,
> 
> -Lars

> Date: Wed, 29 Nov 2017 08:12:23 +0000
> From: Lars Ganrot <lga@napatech.com>
> To: "Michael S. Tsirkin" <mst@redhat.com>
> CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
> Subject: RE: [virtio-dev] [PATCH RFC] packed ring layout spec v5
> Message-ID: <1c66689d2d27414ba6372baecebff18b@napatech.com>
> In-Reply-To: <20171128155148-mutt-send-email-mst@kernel.org>
> 
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: 28. november 2017 15:37
> 
> > > If the device always returns buffers in order, then couldn't the driver skip the
> > >step of reading the used.ring for read-only buffers  (e.g. TX for net devices)? The
> > >used.idx tells how many buffers were returned, and since they are returned in
> > >the same order as the driver sent them, it knows what their indices are. This
> > >would then save one cache-miss in the old structure too.
> >
> > True. That would be another variant to support though.
> >
> > I doubt it'll outperform this one but I didn't test it specifically. Care trying to
> > implement it?
> 
> Agreed, and I don't see it as competing with the packed ring, however if there
> are low hanging fruits, that improve performance of the non-ring structure
> (in at least some significant use cases) they could be worth considering as part
> of a rev 1.1 specification too. I'll see what can be done for a prototype.
> 
> >
> > > And a follow-up questions would then be: if a device always returns buffers in
> > >order, does the v1.0 specification not require drivers to reuse descriptors in the
> > >same order as they are returned? I think 3.2.1.1 implies that at least. If so,
> > >wouldn't new descriptors always be placed back2back in the descriptor table
> > >(contiguous memory)?
> >
> > You probably mean this:
> > 1. Get the next free descriptor table entry, d
> >
> > and you interpret "next" here as "next in ring order".
> >
> > I'm not sure everyone follows this interpretation though.
> >
> > E.g. Linux does:
> > static void detach_buf(struct vring_virtqueue *vq, unsigned int head,
> >                        void **ctx)
> > {
> > ...
> >         vq->vring.desc[i].next = cpu_to_virtio16(vq->vq.vdev, vq->free_head);
> >         vq->free_head = head;
> >
> > So descriptors are added at head of the free list.  Next is interpreted as next on
> > this list.  E.g. with a single request in flight, it looks like a single descriptor will
> > keep getting reused.
> >
> 
> I guess there isn't an explicit enough requirement in v1.0 to claim right or wrong
> with regards to this. Enforcing it could however be made part of a driver
> requirement imposed by the new IN_ORDER feature bit. Thus the IN_ORDER
> feature bit for the non-ring would be defined to enforce that the descriptor indices
> are always processed in-order by both the device and the driver.
> 
> My reason for this is to ensure that new descriptors are placed in a contiguous
> range of the descriptor table, which should improve the L1$ prefetcher hit rate
> for batching, and also provide means for efficient DMA in case of HW-offload.
> With knowledge of the number of elements in each buffer it could maybe also be
> possible to calculate the descriptor index range to DMA.
> 
> BR,
> 
> -Lars


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

