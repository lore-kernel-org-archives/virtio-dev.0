Return-Path: <virtio-dev-return-13239-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BC5EB64DA
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 16:30:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0354442C2E
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 16:30:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA580986812
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 16:30:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DB795986724; Wed,  5 Jul 2023 16:30:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE076986721;
	Wed,  5 Jul 2023 16:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaT+LBsV4Q/AfS8/7v59Ql5biv3gqtAHqTA6iXcYP+M2ZJE2ZhNawXscvy6cXgzh4TsLooIbeH1hstK1q5WA+SB8nRKlamw7t+pq29uncTWMgsUUfZYczVIjGZS9iOpQGGjFLDzr7r6i67KRB/ood4t3L8q9V7OSEk4OsmFz4NbcUDuN+gppwDcmxqifNPk/VhTM5O5x5pPurMl4eY8flyVh5tY2Y8zFBS3f/dr3gDWVQDQ/+b2o4DZ7zRA9leGlxVSdthC3baR34VHvIjNflrMzQ3HQMmMBTT8OAbigfTVGfWwzWFTGahx12dxmsGgvM0tSWYclysH91PR4QnDoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jdgjr4wlUnb2xf2AYk/5WgDRFadj+p41iotx4pe/x6I=;
 b=hPy4u7ANf9dQYGlCHWIVQDRV/c4dMxCKU8XGvorb8aX0W6hytNOz+SdjP1LZkCpC9KojwItFDhE/NxY5OxLMdbONSN1bT1TCYv3qsKImxEHAoD/+pvsOHWyS7DRq5EPE6KXbAkjCKkyhlFPnN9MWkjC/SrZ0zYI8uHp96JNnoppqsm2ir4RlY9Rr013dtl0Svb/yOJYR18ldlBezDeQgQtaIqz7eY7kv/hlt4twXmQYqOTaX8l3ZvomDfZsLoTbZgrvY9EUkPkSRO8hI3WdECm7aQ85L2RaFcN2/5+tHz3PKbKQdVk8BLUAaplNSYMTqGfvQkBjgjwDwaPZUkofUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb
	<maorg@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-dev] Re: [PATCH v9 2/4] admin: Fix section numbering
Thread-Index: AQHZrtCMoqnaHfpeiE2xcEQG7N+PAq+q8/qAgABp+sA=
Date: Wed, 5 Jul 2023 16:29:58 +0000
Message-ID:
 <PH0PR12MB5481645B15D2D6824000496EDC2FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230704233724.22394-1-parav@nvidia.com>
 <20230704233724.22394-3-parav@nvidia.com> <87ilay3c0u.fsf@redhat.com>
In-Reply-To: <87ilay3c0u.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|LV8PR12MB9082:EE_
x-ms-office365-filtering-correlation-id: b2354c6b-1f2b-4ed8-bf38-08db7d751312
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G9fSqUB9/b+mNxPi+CLf6iNDTAcT2o5sTEygzUQ3mwJJrC+ETmJfNpue+ymGsJOgcz8thY7knm8Fe0DwpLaH+tQ3POonjEQnDuy6x1tl950wVpbFSmi6KDDphZCPKuGFXkjkPgUjPZeaI1jcbPeP5semu0iQb7sCMkPN7y3REYbYwiN/rBmm9zzNHKLj0JFzmOQ3/UX5y2YK2qsHtv4z3iOosG+vrEJaBf28pBlNHD0dVekrjlS8crlDEOztBFZgQ5boXJu/aFEwkhMwFmt3HAofEGRyCGxBqYJ5EW65brQs9MgY9SbVUD7vIfURhg0YcEsYpjo+IGIfvq8NSsxZY51H5kTNDSTQfM/lBfWdXmGQvqDje/tTdLySsSY7a0LzjuCWUw78LJcnx2KCadjbNal8gF3/MNmlt2dZtj2aJnn6XZgafK9W+GnRjMSawOo1nx/dC9CfaXf0jJwmnRGkhCTqVlYuWMHm0T4DHdwWIfJ0v0ZUi/E11cLLZ0eDgmB0bjFYVS9LxF71uALlAvNPYjwAuzvxyOdCsWEUn0q6Muk/lMmjNhp8cxxDDIWk0bDZqu+Nsa59ScgUlMzKpX/HYTPEz2iQEANtXxU9fThC2qi3UJGobFsd85OsE+XQb+H/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(7696005)(76116006)(71200400001)(478600001)(110136005)(54906003)(83380400001)(86362001)(38070700005)(33656002)(55016003)(4744005)(66946007)(2906002)(107886003)(186003)(6506007)(26005)(9686003)(122000001)(38100700002)(66556008)(316002)(64756008)(41300700001)(4326008)(66476007)(8936002)(8676002)(66446008)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zliXEnXucKwHfqWb2mcmMLKXD5pxSHw9oQbQhZBUrDm5dHWmVXe6YDF3+tkb?=
 =?us-ascii?Q?XW+y6hQdpDgHzBEqnWLH22oi/UOH3/lJWb4gml8ogUTPnaAH73hSES41bU4w?=
 =?us-ascii?Q?O9JUy8sFfDNK1z1WxatdSUymDfUUsM7ByHXANkvgQ2J8rx9JpYUtli0HemtS?=
 =?us-ascii?Q?Y69eU0blcb9sqB1llr0HDBCKPN/dTMXodg6FJYJ3c1wycwxPKeuz1F68i6p5?=
 =?us-ascii?Q?KDic+mIayCO1akCZOFMVbKJ68j9ptWFFQPS6KMLWQ370ETv5IqULuN1XoWLz?=
 =?us-ascii?Q?WNfN47osBofxTvh5dDpLiKkLKmOJjw7yV4zq0/xea3zMaZACkhNOkOIiKlBK?=
 =?us-ascii?Q?Vt2RIYF1MFwAqDdvSM1qKevjBnySHSKlq57vrWUn7Xe00wSEwItZu3jNcsvt?=
 =?us-ascii?Q?cuR8HlPQLEUZ2DPxmU8xAKnlPQ03PI9fMhJQgpJr26Ov3lnzUf3TGyJRn16u?=
 =?us-ascii?Q?+eEs+Uog2MGA0J6Tx0CrSPNTLtQuxozRhgRB5q4gT4tkhY9q6i3h86TL4gpu?=
 =?us-ascii?Q?PWE5UG4kRUC7dQSwrDk+BOJ0J798dtYXBxxOGpQU5lFlweuYurI8llyC8uz9?=
 =?us-ascii?Q?ReBbmIUHtQnN5Po9kH++1KXK6GPJS57tOqwRNE0UypPlCHhWZKSllvnxtb4u?=
 =?us-ascii?Q?fjL5kNNTgJuQ5nRUHecWAYy3UwUitq5uvxEmb/48F88k7VCwdSivfvkaBwsF?=
 =?us-ascii?Q?yfABJmXimDvQhiPZ9tNiu04ERlEXjNKDEaGaIt0C+G05ws1TtwM3pczKb7/w?=
 =?us-ascii?Q?lBVP3uPY0r8N/7OXCO5KboDMgoFwxlqHLOBCHgxT5NoGddu7lc46CmoWLeZZ?=
 =?us-ascii?Q?fxCWR8dsZp3PMVJ8bOfc/V1UAwCyAwoHfS+CRrjU807vKrJ1sNC2VEVgsrMr?=
 =?us-ascii?Q?mvF3PyOCpCUr/To9Cen9oHzc+PijNoPOGqFWx6Dz5QblKzoQGjw753YvYkao?=
 =?us-ascii?Q?DLir3mQYgfNs4w8GoOD+hZG1mkNG0cLkGFO9diKBZB14oRX0McdkbEGNP+y2?=
 =?us-ascii?Q?ycRd4scqDqHhIvXrtBEKuINsbSzw0LN7daCYYGpuKJBsDxA0TvDf9/7OMKeq?=
 =?us-ascii?Q?wXbhxJ1u/qxtN28YNs3d3/sDHqKqytAlFSLwh4EUgoBuKWwBJ1s7lyZrF7ao?=
 =?us-ascii?Q?QPeyB2N/BA5XYkQODdZk8U1yCXL9wXtI3iMIMWCDRI6VcWE1YDmCGqcUi0YC?=
 =?us-ascii?Q?SwEJ3hCjIbA2WdcXZPqzbDU3wFpmxhq9WuTI9qSLucvtARSAFXkQ0JlRkTym?=
 =?us-ascii?Q?jBMGgRJecKDD3x0MQVHfAXjsNSPbA2LZP2IdIQyuclbl0W38YVh6HL5dTCod?=
 =?us-ascii?Q?kooecJBgZyCVKmwQcNdKRr1H6sN1s2bfFQ+N4ciP6e8S8elG0qAUoNY9POBC?=
 =?us-ascii?Q?L+7wR4OUvGYe9PSnAxz+oVXOmdYGKLJj4phNku4XniYa2qwhiT648HYLroPv?=
 =?us-ascii?Q?CZGQn75AjjL6+OF9sNyMeQqqhzua4reNUR1PRg6HNlXB+GhQuYx2bd9asB8V?=
 =?us-ascii?Q?L1TAdyebeQjQyLanswsz0yoWrZlBO4Q49RSRDDiZPw9QGAymEmYPgsGgoRdA?=
 =?us-ascii?Q?7ieUIlb+MPX34Xms6WY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2354c6b-1f2b-4ed8-bf38-08db7d751312
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 16:29:58.7579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /LJA/nuLyBcff2DtcYGzcbqjzBfnKFIGE1Mh7D/bJ4NXG2MIecmC9QPc1s1GMq7s7F6QuL38nhmPeYkOmdEPzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9082
Subject: RE: [virtio-dev] Re: [PATCH v9 2/4] admin: Fix section numbering



> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Cornelia Huck
> Sent: Wednesday, July 5, 2023 6:10 AM
>=20
> Same thing applies to the normative statements for the admin vq (in the s=
ame
> file) -- do you want to fix that as well?

Yes, let me fix it.
I will do this as pre-work and this patch can depend on it.
So that it can be merged quickly and I don't need to run around with more s=
ide patches for this main series.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

