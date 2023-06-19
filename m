Return-Path: <virtio-dev-return-12961-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDB5EB64DB
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 15:58:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3F0692A8EF
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 15:58:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3676E98644F
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 15:58:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 25CA19863A6; Mon, 19 Jun 2023 15:58:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0EB3C9863A9;
	Mon, 19 Jun 2023 15:58:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OY7DFShnIZek7gNPSP/1nTcvkED7hkw/cryfwG+/LXB0gjlUnCgbZdK5YKhSpUTGHfBuLCRYNKgITP5/hPv25l/TzBjnt4ZR7XJAPJdJlw/6szoBcNlmtKqmF078HfyOOEdd0bh66FQp6F7TRkesr3eWF3zBJ7GDQPf0XmLFoklr2L5pJok10bvlaVB79wgOiFaQaQXZiR5R/JrnK2RN0nhbaTb8KYptgx7wrBvrpYDnR8C8BnfC91CPP9uBBWRklgar0Cuaf1yTgBaj6ChmvIzxkhdWKSAX3zFkZVOjUkAiSSDN+Pn6zhGfQNLmNcjmZ+KxZ/ZvMxfNmDO/awFbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vy1mitBeJAa7uqRpfpWOefvMgKHjTONtfY9MNgCjRRQ=;
 b=bt1SzRXOcX/FbqFus2DUsTT5K1bMnz6MmMo3Oy/dMs93R2hjk6OZhCDYGvPUIisHIbFXW+z78UBFMD2zm5P221Vq2rqa8+ylbF7TLWSd58z3oj0c+lXR9TVFnsdhdha/pm0Oc3ej1slBiwaezkOb53N2EENhDf0CTawQdEWOzqf7AjT12zd228LxSZeEnliO8JRFdyPiHrPM0aX5cZkyGHGgJYKwO5GJB9ECnlCWm1HH7OPLjw65djoTwlc3teJ+/sNPJ9gbLyzwJtW9EH9GdMu1X9gG9nWdpRZmQsi5sdQe+Ubo0/TSAe8HMmb9taL8iwnGXSIi542I5LQYR4N3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v6 0/4] admin: Introduce legacy registers access using AQ
Thread-Index: AQHZnhzH08HObjyFZEiE3Fo/Ogfm06+SGI+ggAAt1wCAAAr+wA==
Date: Mon, 19 Jun 2023 15:58:30 +0000
Message-ID:
 <PH0PR12MB548109D92082E7855D032C77DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <PH0PR12MB54815F02CE10368D6204EC8CDC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619111731-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619111731-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB8260:EE_
x-ms-office365-filtering-correlation-id: 4e6ff6cb-182c-4a2c-6e9c-08db70de06c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Net7WS0tEftDmhdTZFrat3JvjbUJflNM+3HZlFxdsJp44N/pLrGpvFPBkB1COEJk5O0NKFx6h/1fwueb0AhZEyzQnQn8caRai6hlMZmLVOD88xAURQHee8GjSTB8tRO3x5zkoxaIQcoDy4NfxJp8+Fyc5AguXBprzwqWDLyW8uJqKahoSkqtLcVmSIupz15/fqPCejc9LY+cUjsSjZSngXhq9LS7Qz5P/yFkYxtZwT8e1Wdofy4a6q3fdReriF9byRsfQClFvGHzEeny1n3qjt2XRTZgigzvQLlHZXIxZRwdvQUVm7NJIYk/aakwuLPcVWpeSyuXHoZrxKLHJun8sfGx4J3awd20hmpumu+BDw7Q5VGMnAxZdcy9sAw+IIU+8X1xyClQdcf0ikcBn/lWrcVpocXX4urddxQ2gcX09rpc8RaQ0mCuCFR9j3+bEETqLwBBiUSNwcxmoPClk+TDH+AbrlrQt7An5tjh1p2odU3cRs2GG+VlXpP2vwJYg3NoyKjX+An/Wc817lZpVQCCioYJs758vMAChzGBTT+3d6GWCFyBdNJatw31HF1AYB6CKdc3zb8uMeNN+kkbe5iucjwInvdWVU0dGo7Kft9g9EjAc7z4LQnrcmf8Iv0bpI0t
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(38100700002)(122000001)(55016003)(38070700005)(33656002)(558084003)(86362001)(71200400001)(7696005)(26005)(6506007)(107886003)(186003)(8936002)(8676002)(5660300002)(9686003)(52536014)(478600001)(54906003)(316002)(41300700001)(66946007)(4326008)(76116006)(6916009)(66556008)(64756008)(66446008)(66476007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2wKUtWetGOt2QIlP1u57VdN15wkCitLIW7e8GQJfBGMpuc3dvm0dZZKWWTkS?=
 =?us-ascii?Q?KbraYzHYmIwt2AmjnA3e9ab6M6Yg6C1r61n1F5oonGNit4N92ubUXrufPSyD?=
 =?us-ascii?Q?cviRIsf5KFuV3XXmtClolnM5g3nZ5Nn3mXbkuntkINCyTnCgK4cuDBDUNX6n?=
 =?us-ascii?Q?L0hFq41oxNB1Raowe8f1Rvlteqqim29cwb6jbPygkvHLQ1bB9mY23SQRumRT?=
 =?us-ascii?Q?lQCLX0rwmsIQ7oQWKVit0JlHHBAbrwIyj+cnaZKtzYRXJVkbm1p0paUvBaHU?=
 =?us-ascii?Q?9rpNpQtPqPD7FjsZ3Nb6eWj5wUUcki4yscZ19UEKrZc4Z9VC1B/86+mHgOd8?=
 =?us-ascii?Q?O7OjPiryIJXMfO1219GbSCYhnqdc5XJB1HZCfekihbCAa79LPY+aZ88qjaZ2?=
 =?us-ascii?Q?oe4SXhvmYaBNVkQron4E9Kvo6PzUQ2UFXZDGTdmauVoTepsPQwE8vEZfAsIR?=
 =?us-ascii?Q?6yh7L3GdXqCFw30z36AS16+7y/sMx+VlR5XOvfsUGVg3GKVwN9MEAhv178sh?=
 =?us-ascii?Q?aLSV/ugpxeYzNYWb1z58hzuG2OAjOKyzKv/7WlKP4F0naOwx1/syw3JWToxq?=
 =?us-ascii?Q?Te+cD02U8yLdrr8D9xJer6Syz/AWBON4brYvOvHrjnj1SvhAiehehNDhigi9?=
 =?us-ascii?Q?DwyismiYjjTMBuvCRry61g1VF9zOp5Yh8JgpQrM54EUi2oxwS47xfCSiLCII?=
 =?us-ascii?Q?TB2u+wYD1r44nsjRYjg9FUx2j2TAgL2qe48934I2u8R+ChX9Vxm0CCzaHWVZ?=
 =?us-ascii?Q?43xh97ui/xvsMrBprlV/uck98R/aleNyhJ/5QOwTAXaquOyKcwwrJ/ucsYWr?=
 =?us-ascii?Q?S1wYKgEqDVHXTg7zq2aNSD5wZKNCiZsJxyVioGZbPU04LjfOf7pDax6DbIo1?=
 =?us-ascii?Q?poSZA7AEcHY+50ijxJEIvvQX/Aj0lYvQr7w5HBVAtFinNH57fjMx6tVQNuqa?=
 =?us-ascii?Q?vm1Dfblg2BdfrKctwJM/o/mPqIWqdr4sXSDF+GmsLB1G9WxpB/hyqO9Tgdjw?=
 =?us-ascii?Q?Scljs2ZUUMXlf454KmXNC6aqhR/CCURyPfyyAs5tUBs5EfNizffx4JXj3joK?=
 =?us-ascii?Q?Jh4jz10wZPo9UnQADI+Un81TnnR/4poCmmecvIAgqBXOBNnUPnrW0q1bIxBQ?=
 =?us-ascii?Q?lMlo0VXjJxoPGPab1VCQ2f3bLJv0TqwpTBEis6opy6M4LMG7fFKzDPt8aPa9?=
 =?us-ascii?Q?JEqosl/Gq23dkDS+kb072CzdizNZA9wb/4lvwolr39vzizG2npLgvANxs9qn?=
 =?us-ascii?Q?SZVAVz52TTp7FuNH+/W1kFASmFkk5D+43RwC3DVJLoIbZx7rWvBG52n3fRKa?=
 =?us-ascii?Q?BxW6PrkNxIisEcSJvkbxu5c/iuSR5TjqSLrls4PtsDASAZV540M0h6wg8lHH?=
 =?us-ascii?Q?u8R3vMzvYdzAPikKCS7mE902UR9edqmkg4kExX+k85ePo+mVPjAluUCe2Htf?=
 =?us-ascii?Q?RXaGYsl1DimOnrtL/1Qz3dfmQjObqWwZi+FH7W8zMmASaJvI5IKFmwiy614y?=
 =?us-ascii?Q?cenkw/u4ihp5+cau+jui6kSjTGthhQLLwylKKXBiaIuoT4MN0I5JFBUyrg8H?=
 =?us-ascii?Q?7xEq9nqK9OrGQjTmEto=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6ff6cb-182c-4a2c-6e9c-08db70de06c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 15:58:30.1363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvD+cQfSPcrtNn9VOcGIbS2opsxbmwwdRzqDOUBNQupfULnvp90UzxxrX2VC8QVynNGWvGAFq4OlWk1X0hPiUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260
Subject: [virtio-dev] RE: [PATCH v6 0/4] admin: Introduce legacy registers access using AQ



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, June 19, 2023 11:19 AM
>=20
> Just back from travel. I remember having comments, will send in a day or =
two. I
> don't think we are talking about editorial things though.

Let me know what are those new one those were not asked in v4.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

