Return-Path: <virtio-dev-return-11626-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51704C61DA4
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 14:24:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8B366157EEF
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 14:24:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 810D798646D
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 14:24:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 74E74986406; Wed, 15 Mar 2023 14:24:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 60300986402;
	Wed, 15 Mar 2023 14:24:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRxMY+oUup7kjXhHP2B6kIDDuR4VyLB8s013siK0GQcEgitm5z7iOq+BjeEk4DoqxJ/1SsjJ9/6g0vMlFA6H3YHkMoLCrz8NK8ccKyK369JOoOopjD2hCaq1n2VKy9oN0jynfJiHeDDa7FznknOKQwBhVo+0zi4cz58RYJz1J5vjUx3JMHQRXlrwJ6Tj7z+FRL/23ynWkfz6eMkmf0ILgZ3rxX2LiTjOaAfLV+2soZueKRdjkrNbvncTqkJBnOWqys/O5fQWMWFZCGbTPfO3mVjh08xfjAxPCDoBqMzAgeibvWw0nviG/M8WfSzPx6hGLq++i4goRQB08N652xkhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gzNCqkDwFcX1+U1RsITepS8jc8+p17THa0f1T/IPzQ=;
 b=CVk+5zm8kweO4HaZKd+3AcQvpoW3+OS9KJ2lcM453BUgk17uKDd2nCSWWopQ5u1lwixCeQLNu54qW298Fu9iu4cvqA3UhCqu6Gxp8YwHem1D61bDpBERmCDTe7mrddzYoboE+MfhVKRq4klkqaYwqdbFs/MUYS+O1HJoCO4pEq4PcAYCleErLCRf/KD5M3W+k4Vz//LTetgzXcCOoIEKy0cekavwRfzfw+os/mofAIDSlGFP1ytYchOa5TA4aERRqcvGWEQl6zOW1s/VgO0CkghIdddIGyW8NHURwWzeXTkOy0Ofg4UuxWp+JBoNAKF2AtI/s0e5a2kfEg5uoF/qkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH] virtio-blk: Define dev cfg layout
 before its fields
Thread-Index: AQHZR44SBM2m5bVfBEeSkO5d+VQF6a7dAKGAgBo7NtCABMicIA==
Date: Wed, 15 Mar 2023 14:24:27 +0000
Message-ID:
 <PH0PR12MB54811AF45A8A935B17806632DCBF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230223135205.175949-1-parav@nvidia.com>
 <Y/fQl7ImbYGHEtVY@fedora>
 <PH0PR12MB54812629987A9530712C0649DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB54812629987A9530712C0649DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB8134:EE_
x-ms-office365-filtering-correlation-id: 2763a01e-560c-452f-0311-08db2560fbba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4V2ilg4sHbaKz2PGT52YeN4mJMjtGRmSZawG5hWlVZpdO/JxJAoeeO7bpFf6rNTwM7MOTuphlguvXxyBftDeh+hTNum8XQH6sivYSZGMJkScARJlGrkHB+htiC8MwybKRflqEPWccT2Zdv3LQe0oFgWm8r3Hl98AziIj7JXiLXGypLoXynzXB+j047XqK8QW0rNHyU9Dss02XfbO/qdcUAJL1e4yFmbPJV3xblMQb8vED1sWnEE2h0e5vkpWj8wP2G0ACm2e0rHZ31k8fOSRtqA14vo5FZEC/WF5vA03kzbUl7W9SX6N1Tb+OhNrOYkO51H0axl5a+HassxOYaL/uGZDjGF/1DihT94e7bFI46mOQM9wQWdRPyNwxcaJaeAI9DBT3/dmb2ZdnONiCs3JRj1OeZ3fAFl9vh0KQlLwmET276O8M5PGusgLA35F0LOldZRAnpv4T+Du+/zEc2wICP7VujfmC6JK/FZ1qcXU9TzFSQFEsqqi8mqYttS5+H+Ioe+XGsd9pQwnb3TubY6EIslyzF1IleAh824py1hWj5hmUVN3YvL/J73D+xbR7jWUoRr2iRR34Gj3MZhI7fscwkwb3LaI3Ycb/9P5tU6NcsuC9V9Lmv6ZrjX0IQjVtGnBUOXApKxSKMp4sPeKTJ2pFfXMKBOaipsRCUZzGCac7ukbUNvqdF2JtJC5rORmiTfsdUxPJg7fDHRDlAzGVFEh5Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199018)(122000001)(38100700002)(2906002)(6506007)(54906003)(110136005)(33656002)(107886003)(38070700005)(478600001)(86362001)(71200400001)(55016003)(66946007)(8676002)(64756008)(66446008)(66476007)(41300700001)(4326008)(66556008)(316002)(52536014)(7696005)(8936002)(9686003)(5660300002)(4744005)(83380400001)(76116006)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6LbRn/llBvjJxC6B+uB33MWMtmGGFZYXAkVrTImqMsmL0DPPAzsgP4eGuvcP?=
 =?us-ascii?Q?44Dxild4j7I2GhqjNYWq6gOA0G5VyXibm10Oy525C6g2MweGzzNw82BZZJYO?=
 =?us-ascii?Q?boxRkJWRQiHNg0ZtL2aLTNOibyYPxbhMRKY39cG2hxh5YqnCp2kvTY9Bxu1Z?=
 =?us-ascii?Q?1KpTxiIejrWV2TDlxJs7bzhgPtmLJ1sCasLNneuYMSgRlxpkZoGkISmdMyJu?=
 =?us-ascii?Q?Xe8AJzDw6X/nE68eGlVy0kjerw7AWflKm2GfJZrvklKo2hDAtQWakqS0FXNs?=
 =?us-ascii?Q?O440fVQGeLiXEsm7azQIIoNxj2D+432DDg6dGqToqgfbyBj+ZIJpAyauFOWu?=
 =?us-ascii?Q?RqfwEMPz0eMkd3wLnOlvXBwBIpx8hLjqTocxBBE04uqCcqA4npz5F+oSTTlp?=
 =?us-ascii?Q?5h9XFirbg3JuKW34MGZ16K8tBG0MHnUAVwGtDtULShpb/hn/3pLV9EV7dTPR?=
 =?us-ascii?Q?iJ3Qq8scGaP9N+95F6/2yWi7ygb/ED5rwtDLmaGIOxRFxhJSrE7hdCbL8HvG?=
 =?us-ascii?Q?GlTo3d6hLMITdCZo3W36Pf9NmFmU1YrdtZ7l4MezUssK/sgofeeepdkj4GfJ?=
 =?us-ascii?Q?fx3Agsmtg3TuGc6DGYVRf60oxvujycyLknduf3irnuQwPWiN1OlyOJjrC+Lm?=
 =?us-ascii?Q?p+20u0RAZ4IP+zDpbbc6CF6pwMUVYTI4V8oEumvlpo3PVSLZXxW3aFeJSJzc?=
 =?us-ascii?Q?EdhcqeG1MmMFq1WCIDl1GeAUvxFUyZ+JpN3+xof8uOcizVMblEmGor5Jf/u8?=
 =?us-ascii?Q?0KSEePX/okANUvWiO8i9oJd19/zTZQP8+1T28TBFOlN/XFgZ41/g4WdUVDiw?=
 =?us-ascii?Q?73FEBEoZRuNZxkz8hER9fEdT0Sn3Kt6Uf5bnL0KAmUK1w47uYH8ELzd2V8S/?=
 =?us-ascii?Q?cfAfeReSlsvMGkFLbo8Jw+gUJtj0kIPkjXi4biTKGAeM8Ha1aq56DxeHaX5u?=
 =?us-ascii?Q?9pibD7SvUgu2rDBnXQD8XSeOaVIoZPLO16FmRZiM5we+TIwuXXl/ctS098/i?=
 =?us-ascii?Q?icrb7B9efV238WO9ytMJdKj524lhQaGaq1Nx8DANZsm/J4co5TMcf6kJOSZs?=
 =?us-ascii?Q?YJ42cnzdDc65X2fTTUZXObUdxcuT8VuzDsSX3cPxENYI/Dec4EQ8XPgUvUic?=
 =?us-ascii?Q?nB9C1tik/34Vs35aZlvKSLdbFKtBxZ1JFXEY1xWYQfn5IxA0SP9xxNWPhNVb?=
 =?us-ascii?Q?BdhLX/UydliYmmbVSPW0PlTDlDK+VwbjGZGsuFQhpvyiMH3CZw7y3Kp1VVhX?=
 =?us-ascii?Q?SKV+0mKhzSKSHjugCNvHxyH4JFC435ic20konE6sOjlkDP9TzeVmfkUew/KY?=
 =?us-ascii?Q?7JQMjkKQhjDVMsR6odluMUVKDQV7s8NJ+PqOotX9CfgreY416qqKSiLymfCW?=
 =?us-ascii?Q?dWIN4Nc0jrZqonLm+8X5f41PN0p+tZtul1EsIXxKAumMRzykcuFxN553JXwA?=
 =?us-ascii?Q?DMvVc9qZCWncRwcyWp1R9zN7S6gFwjEHTaUgSIBYqCeiKEDOf7fCXCvfNdPg?=
 =?us-ascii?Q?tsKRnk3mnnrYLI9BNOhMAR+jDCdQ0q0YYDyBPKNuDemQ79YyYTok1WMA0avl?=
 =?us-ascii?Q?lCGAYxXODewCgcbFblapSyicpgOXF7qDHasNpg/AK7Aj2Mbww/n0+KQy1riu?=
 =?us-ascii?Q?buQIQ5/rmRJbMVjTDJZN7co=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2763a01e-560c-452f-0311-08db2560fbba
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 14:24:27.2792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQrtKHbmw/t6XbXO8ssyVI1R6vr1KS6BPamLW8cw1a78qHNEoalJFyN0qNeBnkPwggL4TnmlB1PZQVAVDSTpvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134
Subject: [virtio-dev] RE: [virtio-comment] [PATCH] virtio-blk: Define dev cfg layout before
 its fields


> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Parav Pandit
>=20
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > Sent: Thursday, February 23, 2023 3:46 PM
> >
> > On Thu, Feb 23, 2023 at 03:52:05PM +0200, Parav Pandit wrote:
> > > Define device configuration layout structure before describing its
> > > individual fields.
> > >
> > > This is an editorial change.
> > >
> > > Suggested-by: Cornelia Huck <cohuck@redhat.com>
> > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > >  device-types/blk/description.tex | 95
>=20
> [..]
>=20
> > Yes, please!
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Hi Cornelia,
>=20
> Can you please merge this?

Any updates?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

