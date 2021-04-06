Return-Path: virtio-dev-return-8131-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0B1DA9863D1
	for <virtio-dev@lists.oasis-open.org>; Tue,  6 Apr 2021 17:31:17 +0000 (UTC)
MIME-Version: 1.0
References: <CABATKF_wnHQRrmBV=yKE-wrOMGXxX6=Pz=PwgZy+-DXrVQ+7ZA@mail.gmail.com>
 <20210330115114.4cb89229.cohuck@redhat.com> <CABATKF9YyYwBGOhSX0wKRB1t3OG+1DAKdmfzwHnAu5+f+M68Fg@mail.gmail.com>
 <20210406120942.4bd1a5a9.cohuck@redhat.com>
In-Reply-To: <20210406120942.4bd1a5a9.cohuck@redhat.com>
From: Hao Chen <chenhaosjtuacm@google.com>
Date: Tue, 6 Apr 2021 10:31:04 -0700
Message-ID: <CABATKF8W7ayO1J5ZqpYb72sx5fP75-PRhRzdTG+yVazqwbfHEA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v2] Reserve device id for parameter server
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

GitHub issue updated

On Tue, Apr 6, 2021 at 3:09 AM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Tue, 30 Mar 2021 12:34:19 -0700
> Hao Chen <chenhaosjtuacm@google.com> wrote:
>
> > Use device ID 38
> >
> > Signed-off-by: Hao Chen <chenhaosjtuacm@google.com>
> > ---
> >  content.tex | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index b72bad0..cc292b3 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -2870,6 +2870,8 @@ \chapter{Device Types}\label{sec:Device Types}
> >  \hline
> >  36         &   CAN device \\
> >  \hline
> > +38         &   Parameter Server \\
> > +\hline
> >  \end{tabular}
> >
> >  Some of the devices above are unspecified by this document,
>
> Can you please edit the github issue so that 38 is mentioned in its
> title, and the description (not a comment) is linking to this patch?
> (We use that data to create the ballot.)
>
> Thanks!
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

