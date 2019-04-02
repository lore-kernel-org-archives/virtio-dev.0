Return-Path: virtio-return-3345-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 2 Apr 2019 15:46:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190402154537-mutt-send-email-mst@kernel.org>
References: <20190328191135.25628-1-mst@redhat.com>
 <20190328151221-mutt-send-email-mst@kernel.org>
 <36c45416af1b4d4e94ed184b916b3e61@napatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36c45416af1b4d4e94ed184b916b3e61@napatech.com>
Subject: [virtio] Re: [virtio-dev] Re: [PATCH] acknowledgements: add commenters from
 mailing list
To: Lars Ganrot <lga@napatech.com>
Cc: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Thanks!
Fixed up in the lates cs01 doc and uploaded to virtio-docs.
Check it out!


On Tue, Apr 02, 2019 at 06:29:50PM +0000, Lars Ganrot wrote:
> Hi Michael,
> 
> The recent commit:
> 
> https://github.com/oasis-tcs/virtio-docs/commit/4108c07b7382911a9dfea21d35a765d7da999ba3
> 
> p160 of the pdf seems to be badly formatted. The list of Acknowledgements spills over the page end. Seen in both Edge and Acrobat.
> 
> BR,
> 
> -Lars
> 
> -----Original Message-----
> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On Behalf Of Michael S. Tsirkin
> Sent: 28. marts 2019 20:13
> To: virtio@lists.oasis-open.org; virtio-dev@lists.oasis-open.org
> Subject: [virtio-dev] Re: [PATCH] acknowledgements: add commenters from mailing list
> 
> On Thu, Mar 28, 2019 at 03:11:39PM -0400, Michael S. Tsirkin wrote:
> > Not all commenters sent an orderly "Reviewed-by" tag.  Some just
> > contributed to the discussion on the mailing list.
> > Add their names and affiliation from the mailing list archives.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> 
> Note: this is not yet in the latest draft, but since this is trivially non-material I intend to add this change before we vote on 1.1-cs01
> 
> >  acknowledgements.tex | 45
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/acknowledgements.tex b/acknowledgements.tex index
> > b2feeaf..1dcbe44 100644
> > --- a/acknowledgements.tex
> > +++ b/acknowledgements.tex
> > @@ -65,42 +65,87 @@
> > \chapter{Acknowledgements}\label{chap:Acknowledgements}
> >
> >  \begin{oasistitlesection}{Reviewers}
> >  Aaron Conole,Red Hat\newline
> > +Adam Tao,Huawei\newline
> > +Alexander Duyck,Intel\newline
> > +Andreas Pape,ADITG/ESB\newline
> >  Andrew Thornton,  Google \newline
> >  Arun Subbarao,LynuxWorks\newline
> >  Baptiste Reynal,Virtual Open Systems\newline
> > +Bharat Bhushan,NXP Semiconductors\newline
> >  Brian Foley,  ARM \newline
> > +Chandra Thyamagondlu,Xilinx\newline
> >  Changpeng Liu,Intel\newline
> >  Christian Pinto,Virtual Open Systems\newline
> >  Christoffer Dall,ARM\newline
> > +Christoph Hellwig,Individual \newline
> >  Christian Borntraeger,IBM\newline
> >  Daniel Marcovitch,Mellanox\newline
> >  David Alan Gilbert, Red Hat \newline
> >  David Hildenbrand,Red Hat\newline
> > +David Riddoch,Solarflare\newline
> > +Denis V. Lunev,OpenVZ\newline
> > +Dmitry Fleytman,Red Hat\newline
> > +Don Wallwork,Broadcom\newline
> > +Emily Drea,ARM\newline
> > +Eric Auger,Red Hat\newline
> >  Fam Zheng, Red Hat\newline
> > +Francesco Fusco,Red Hat\newline
> > +Frank Yang,Google\newline
> >  Gil Savir,Intel\newline
> >  Gonglei (Arei),Huawei\newline
> > +Greg Kurz,IBM\newline
> >  Hannes Reiencke, SUSE\newline
> > +Ian Campbell,Docker\newline
> > +Ilya Lesokhin,Mellanox\newline
> >  Jacques Durand,Fujutsu\newline
> > +Jakub Jermar,Kernkonzept\newline
> > +Jan Scheurich,Ericsson\newline
> > +Jason Baron,Akamai\newline
> >  Jason Wang, Red Hat \newline
> >  Jean-Philippe Brucker,ARM\newline
> > +Jianfeng Tan,intel\newline
> >  Jonathan Helman,Oracle\newline
> > +Karandeep Chahal,DDN\newline
> >  Kevin Lo,MSI\newline
> > +Kevin Tian,Intel\newline
> > +Kully Dhanoa,Intel\newline
> >  Laura Novich, Red Hat\newline
> >  Ladi Prosek,Red Hat\newline
> > +Lars Ganrot,Napatech\newline
> >  Longpeng (Mike),Huawei\newline
> > +Mario Torrecillas Rodriguez,ARM\newline
> > +Mark Rustad,Intel\newline
> >  Maxime Coquelin,Red Hat\newline
> >  Namhyung Kim,LG\newline
> > +Ola Liljedahl,ARM\newline
> > +Pankaj Gupta,Red Hat\newline
> >  Patrick Durusau,Technical Advisory Board, OASIS\newline
> > +Pierre Pfister,Cisco\newline
> > +Pranavkumar Sawargaonkar,Linaro\newline
> > +Rauchfuss Holm,Huawei\newline
> > +Rob Miller,Broadcom\newline
> > +Roman Kiryanov,Google\newline
> >  Robin Cover,Technical Advisory Board, OASIS\newline
> > +Roger S Chien,Intel\newline
> >  Sameeh Jubran,Red Hat / Daynix\newline
> > +Si-Wei Liu,Oracle\newline
> >  Sridhar Samudrala,Intel\newline
> > +Stefan Fritsch,Individual \newline
> >  Stefano Garzarella,Red Hat\newline
> > +Steven Luong,Cisco\newline
> >  Thomas Huth,Red Hat\newline
> >  Tiwei Bie,Intel\newline
> >  Tomáš Golembiovský,Red Hat\newline
> > +Venu Busireddy,Oracle\newline
> >  Victor Kaplansky,Red Hat\newline
> > +Vijayabhaskar Balakrishna,Oracle\newline
> > +Vlad Yasevich,Red Hat\newline
> >  Yan Vugenfirer, Red Hat / Daynix\newline
> > +Wei Xu,Red Hat\newline
> >  Will Deacon,ARM\newline
> > +Willem de Bruijn,Google\newline
> > +Yuanhan Liu,Intel\newline
> >  Yuri Benditovich,Red Hat / Daynix\newline
> > +Zhi Yong Wu,IBM\newline
> >  Zhoujian,Huawei\newline
> >  \end{oasistitlesection}
> > --
> > MST
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
> Disclaimer: This email and any files transmitted with it may contain confidential information intended for the addressee(s) only. The information is not to be surrendered or copied to unauthorized persons. If you have received this communication in error, please notify the sender immediately and delete this e-mail from your system.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

